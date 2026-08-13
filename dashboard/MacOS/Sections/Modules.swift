//
//  Modules.swift
//  DMCRE-ARC-DEBUGGER
//
//  Created by Lilith on 01.04.26.
//

import SwiftUI
import Combine

struct Module: Identifiable {
	var id = UUID();

    var path: String = ""
    var domain: String = ""
    var type: String = ""
}

struct Section: Identifiable {
	var id = UUID();
	
	var file: String = "";
	var name: String = "";
	var start: Int64 = 0;
	var end: Int64 = 0;
}

class ModuleData: ObservableObject {
    @Published var modules: [Module] = []
	@Published var sections: [Section] = []

    func onMessage(message: [String: Any]) {
		if(message["event"] as? String == "modules/load") {
			guard
				let domain = message["domain"] as? String,
				let path = message["path"] as? String,
				let type = message["type"] as? String
			else {
				return;
			}
			
			let module = Module(path: path, domain: domain, type: type);
			
			DispatchQueue.main.async {
				self.modules.append(module)
			}
		}
		else if(message["event"] as? String == "modules/section") {
			guard
				let file = message["file"] as? String,
				let name = message["name"] as? String,
				let start = message["start"] as? Int64,
				let end = message["end"] as? Int64
			else {
				return;
			}
			
			let section = Section(file: file,name: name,start: start,end: end);
			
			DispatchQueue.main.async {
				self.sections.append(section)
			}
		}
    }
}


struct LoadTypeDisplayInfo {
	let hue: Double;
	let icon: String;
	
	func color() -> Color {
		return Color(
			hue: hue,
			saturation: 0.7,
			brightness: 0.8
		);
	}
}

private func GetLoadTypeDisplayInfo(type: String) -> LoadTypeDisplayInfo {
	if(type == "c++") {
		return LoadTypeDisplayInfo(hue: 270/360,icon: "text.document.fill");
	}
	if(type == "dll") {
		return LoadTypeDisplayInfo(hue: 100/360,icon: "building.columns");
	}
	return LoadTypeDisplayInfo(hue: 0/360,icon: "questionmark");
}

struct ModulesView: View {
    @StateObject var data: ModuleData
	
	enum NavItem: CaseIterable, NavigationItem {
		case Modules
		case Sections
		
		var id: String { title }
		
		var title: String {
			switch self {
				case .Modules:
					return "Modules"
				case .Sections:
					return "Sections"
			}
		}
		
		var systemImage: String {
			switch self {
				case .Modules:
					return "list.triangle"
				case .Sections:
					return "chart.bar.horizontal.page.fill"
			}
		}
	}
	@State private var navSelection: NavItem = .Modules

    var body: some View {
		TopTabNavigation(items: NavItem.allCases,selection: $navSelection) {
			// MARK: Modules
			if(navSelection == .Modules) {
				Table(data.modules) {
					TableColumn("") { module in
						Image(systemName: GetLoadTypeDisplayInfo(type: module.type).icon)
							.foregroundStyle(GetLoadTypeDisplayInfo(type: module.type).color())
					}
					.width(20)
					
					TableColumn("type") { module in
						Text(module.type)
							.foregroundStyle(GetLoadTypeDisplayInfo(type: module.type).color())
					}
					.width(100)
					
					TableColumn("domain") { module in
						Text(module.domain)
					}
					.width(100)
					
					TableColumn("path") { module in
						Text(module.path)
					}
				}
			}
			else if(navSelection == .Sections) {
				Table(data.sections) {
					TableColumn("file") { section in
						Text(section.file)
					}
					.width(min: 0, ideal: 850, max: .infinity)
					
					TableColumn("name") { section in
						Text(section.name)
					}
					.width(min: 0, ideal: 300, max: .infinity)
					
					TableColumn("start") { section in
						Text("0x" + hex(section.start,width: 16))
					}
					.width(min: 0, ideal: 250, max: .infinity)
					
					TableColumn("end") { section in
						Text("0x" + hex(section.end,width: 16))
					}
					.width(min: 0, ideal: 250, max: .infinity)
				}
			}
		}
    }
}
