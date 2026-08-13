//
//  HeadersView.swift
//  dmcre
//
//  Created by Lilith on 03.04.26.
//

import SwiftUI
import Foundation

private struct FoldableHeaderView: View {
	let color: Color;
	let path: String;
	let displayName: String;
	
	@State var open: Bool = false;
	@State var text: String = "";

	var body: some View {
		VStack {
			HStack(spacing: 10) {
				HStack {
					Image(systemName: "text.document.fill")
						.foregroundStyle(color)
					
					Text(displayName)
						.foregroundStyle(color)
				}
				.frame(alignment: .leading)
				
				HStack {
					Button(
						action: {
							open = !open;
							if(open) {
								do {
									guard let data = try FileHandle(forReadingFrom: URL(fileURLWithPath: path)).readToEnd() else {return};
									guard let decoded = String(data: data, encoding: .utf8) else {return};
									text = decoded;
								} catch(let error) {
									NSLog(error.localizedDescription)
								}
							} else {
								text = "";
							}
						},
						label: {
							Image(systemName: open ? "chevron.down" : "chevron.forward")
						}
					)
				}
				.frame(alignment: .trailing)
			}
			.frame(maxWidth: .infinity,alignment: .leading)
			
			if(open) {
				ScrollView {
					VStack {
						ForEach(text.split(separator: "\n").enumerated(),id: \.offset) { index,line in
							HStack {
								Text(String(index))
									.frame(width: 25,alignment: .trailing)

								Text(line)
									.frame(maxWidth: .infinity,alignment: .leading)
									.lineLimit(1)
							}
							.frame(maxWidth: .infinity,alignment: .leading)
						}
					}
					.frame(maxWidth: .infinity,alignment: .leading)
				}
			}
		}
		.padding(10)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(.thinMaterial)
		.clipShape(.rect(cornerRadius: 8))
		.overlay {
			RoundedRectangle(cornerRadius: 8)
				.stroke(color, lineWidth: 2)
		}
	}
}

struct HeadersView: View {
	@State var files_cxx: [String] = [];
	let path_headers_cxx = Bundle.main.bundlePath+"/Contents/Resources/Headers/C++";

	func refreshFiles() {
		do {
			let files = try recursiveContents(of: URL(fileURLWithPath: path_headers_cxx));
			files_cxx = files.map({file in
				return String(file.dropFirst(path_headers_cxx.count+3));
			});
		} catch(let error) {
			NSLog(error.localizedDescription);
		}
	}

	var body: some View {
		VStack {
			ScrollView {
				ForEach(files_cxx, id: \.self) { file in
					FoldableHeaderView(
						color: Color(hue: 270 / 360, saturation: 0.5, brightness: 0.8),
						path: path_headers_cxx+"/"+file,
						displayName: file
					)
				}
			}
			.padding(20)
		}
		.frame(maxWidth: .infinity, alignment: .topLeading)
		.background(Color(NSColor.windowBackgroundColor))
		.task {
			refreshFiles();
		}
	}
}
