//
//  ParserDebuggerView.swift
//  dmcre
//
//  Created by Lilith on 09.08.26.
//

import SwiftUI
import AppKit

@Observable public final class ParserDebuggerViewState {
	@Observable public final class Character: Identifiable {
		public let id = UUID();

		public let str: String;
		
		public var color = NSColor(hue: 0/360, saturation: 0.00, brightness: 1.00, alpha: 1.00)
		
		public init(str: String) {
			self.str = str
		}
	}
	
	@Observable public final class Line: Identifiable {
		public let id = UUID();

		public var characters: [Character] = [];
	}
	
	public var lines: [Line] = [];
}

struct ParserDebuggerView: View {
    let viewState: ParserDebuggerViewState

    var body: some View {
		ScrollView([.horizontal, .vertical],showsIndicators: true) {
			VStack(alignment: .leading,spacing: 0) {
				ForEach(viewState.lines) { line in
					HStack(alignment: .top,spacing: 0) {
						ForEach(line.characters) { char in
							Text(char.str)
								.foregroundColor(Color(nsColor: char.color))
								.fixedSize()
						}
					}
					.fixedSize(horizontal: true, vertical: false)
				}
			}
			.fixedSize(horizontal: true, vertical: true)
			.font(.custom("Jetbrains Mono",size: 12))
		}
        .frame(minWidth: 1200, minHeight: 500)
		.frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
    }
}

@objc(ParserDebuggerViewController) public final class ParserDebuggerViewController: NSObject {
	public var viewState = ParserDebuggerViewState();
	
	@MainActor @objc public func setText(characters: UnsafePointer<UInt32>,count: UInt64) {
		viewState.lines = [];
		var line = ParserDebuggerViewState.Line();
		
		(0..<Int(count)).forEach { i in
			let charCode = characters.advanced(by: i).pointee;
			if(charCode == 0x0a) {
				viewState.lines.append(line);
				line = ParserDebuggerViewState.Line();
			} else {
				line.characters.append(
					ParserDebuggerViewState.Character(
						str: UnicodeScalar(charCode) != nil ? String(UnicodeScalar(charCode)!) : String("<bad character>")
					)
				);
			}
		}
		if(line.characters.count > 0) {
			viewState.lines.append(line);
		}
	}
	
	@MainActor @objc public func setCharacterColor(index: UInt64,color: NSColor) {
		var i = Int(truncatingIfNeeded: index);
		for lI in viewState.lines.indices {
			if viewState.lines[lI].characters.count > i {
				viewState.lines[lI].characters[i].color = color;
				break;
			} else {
				i -= viewState.lines[lI].characters.count;
				if(i < 0) {
					break;
				}
			}
		}
	}
	
	@MainActor @objc public func getView() -> NSView {
		return NSHostingView(
			rootView: ParserDebuggerView(viewState: viewState)
		);
	}
}
