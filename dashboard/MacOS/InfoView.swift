//
//  InfoView.swift
//  dmcre
//
//  Created by Lilith on 04.04.26.
//

import SwiftUI

struct InfoView: View {
	@AppStorage("runtimeExecutableLinkPath") var runtimeExecutableLinkPath: String = "/usr/local/bin/dmcre";
	@AppStorage("runtimeExecutableAutoLink") var runtimeExecutableAutoLink: Bool = false;
	
	var body: some View {
		VStack(alignment: .leading,spacing: 50) {
			VStack(alignment: .leading,spacing: 10) {
				Text("DMCRE")
				Text("version: 2.0.0")
			}
			
			VStack(alignment: .leading,spacing: 10) {
				
				Toggle(isOn: $runtimeExecutableAutoLink) {
					Text("automatically link executable on application startup")
				}
				.toggleStyle(.checkbox)

				TextField(
					"runtime executable link path",
					text: $runtimeExecutableLinkPath
				)
				.lineLimit(1)
				
				Button(
					action: {
						do {
							if(FileManager.default.fileExists(atPath: runtimeExecutableLinkPath)) {
								try FileManager.default.removeItem(atPath: runtimeExecutableLinkPath);
							}

							try FileManager.default.createSymbolicLink(
								atPath: runtimeExecutableLinkPath,
								withDestinationPath: Bundle.main.bundlePath+"/Contents/MacOS/Runtime",
							);
						} catch(let error) {
							NSLog(error.localizedDescription)
						}
					},
					label: {
						Text("create link")
					}
				)
			}
		}
		.padding(50)
		.frame(
			minWidth: 500,maxWidth: .infinity,
			minHeight: 300,maxHeight: .infinity,
			alignment: .topLeading
		)
		.background(Color(NSColor.windowBackgroundColor))
	}
}
