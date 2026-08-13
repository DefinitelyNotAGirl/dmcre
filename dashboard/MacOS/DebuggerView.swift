//
//  DebuggerView.swift
//  DMCRE-ARC-DEBUGGER
//
//  Created by Lilith on 01.04.26.
//

import SwiftUI

struct DebuggerView: View {
	enum SidebarItem: NavigationItem, CaseIterable {
		case modules
		case arc
		
		var id: String {
			switch self {
			case .modules:
				return "Modules"
			case .arc:
				return "ARC"
			}
		}
		
		var title: String {
			switch self {
			case .modules:
				return "Modules"
			case .arc:
				return "ARC"
			}
		}
		
		var systemImage: String {
			switch self {
			case .modules:
				//return "building.columns"
				return "books.vertical"
			case .arc:
				return "memorychip"
			}
		}
	}
	@State private var selection: SidebarItem = .modules
	@StateObject var debugger: Debugger;
	
	@AppStorage("font") var font: String = "JetBrains Mono"
	
	var body: some View {
		SidebarNavigation(items: SidebarItem.allCases, selection: $selection) {
			if(selection == .modules) {
				ModulesView(data: debugger.moduleData)
			}
			else if(selection == .arc) {
				ARCView(data: debugger.arcData)
			}
		}
		.font(.custom(font,size: 12))
	}
}


