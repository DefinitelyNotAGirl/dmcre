//
//  ControlView.swift
//  DMCRE-ARC-DEBUGGER
//
//  Created by Lilith on 03.04.26.
//

import SwiftUI
import Network

func recursiveContents(of directory: URL) throws -> [String] {
	let keys: [URLResourceKey] = [.isDirectoryKey]
	guard let enumerator = FileManager.default.enumerator(
		at: directory,
		includingPropertiesForKeys: keys,
		options: [.skipsHiddenFiles]
	) else {
		return []
	}
	
	var results: [String] = []
	
	for case let fileURL as URL in enumerator {
		results.append(fileURL.path())
	}
	
	return results
}

struct ControlView: View {
	@StateObject var App: AppDelegate;
	@AppStorage("font") var font: String = "JetBrains Mono"

	enum SidebarItem: CaseIterable, NavigationItem {
		case Info
		case DebuggerList
		case Headers
		
		var id: String {
			switch self {
			case .DebuggerList:
				return "Debugger list"
			case .Info:
				return "Info"
			case .Headers:
				return "Headers"
			}
		}
		
		var title: String {
			switch self {
			case .DebuggerList:
				return "Debugger list"
			case .Info:
				return "Info"
			case .Headers:
				return "Headers"
			}
		}
		
		var systemImage: String {
			switch self {
			case .DebuggerList:
				return "list.triangle"
			case .Info:
				return "info.circle.fill"
			case .Headers:
				return "books.vertical.fill"
			}
		}
	}
	@State private var selection: SidebarItem = .Info

	var body: some View {
		SidebarNavigation(items: SidebarItem.allCases, selection: $selection) {
			if(selection == .DebuggerList) {
				VStack {
					ForEach(App.Debuggers) { debugger in
						HStack {
							Text(debugger.connection.debugDescription)
						}
					}
				}
			}
			else if(selection == .Info) {
				InfoView()
			}
			else if(selection == .Headers) {
				HeadersView()
			}
		}
		.font(.custom(font, size: 12))
	}
}
