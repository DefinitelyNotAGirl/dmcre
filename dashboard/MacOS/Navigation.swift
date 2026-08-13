//
//  Navigation.swift
//  dmcre
//
//  Created by Lilith on 05.04.26.
//

import SwiftUI

protocol NavigationItem: Identifiable, Equatable {
	var systemImage: String {get};
	var title: String {get};
}

struct TopTabNavigation<Item,Content>: View where Content: View, Item: NavigationItem {
	let items: [Item];
	var selection: Binding<Item>;
	let content: () -> Content;

	init(
		items: [Item],
		selection: Binding<Item>,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.items = items;
		self.selection = selection;
		self.content = content;
	}
	
	var body: some View {
		VStack(spacing: 0) {
			Group {
				HStack(spacing: 20) {
					ForEach(items) { item in
						HStack(spacing: 5) {
							Button (
								action: {
									selection.wrappedValue = item
								},
								label: {
									Image(systemName: item.systemImage)
									Text(item.title)
								}
							)
							.foregroundStyle(Color(NSColor(
								calibratedHue: NSColor.controlAccentColor.usingColorSpace(.deviceRGB)?.hueComponent ?? 0,
								saturation: selection.wrappedValue == item ? 1.0 : 0.0,
								brightness: 1.0,
								alpha: 1.0
							)))
							.buttonStyle(.borderless)
							.frame(maxWidth: .infinity)
							.padding(5)
						}
						.clipShape(.rect(cornerRadius: 16))
					}
				}
				.background(.bar)
				.frame(maxWidth: .infinity)
				.clipShape(.rect(cornerRadius: 16))
				.padding(.all,10)
				.lineLimit(1)
			}
			.background(.ultraThinMaterial)
			
			Group {
				content()
			}
		}
		.frame(
			minWidth: 0,maxWidth: .infinity,
			minHeight: 0,maxHeight: .infinity,
			alignment: .topLeading
		)
		.ignoresSafeArea(.container)
	}
}

struct SidebarNavigation<Item,Content>: View where Content: View, Item: NavigationItem {
	let items: [Item];
	var selection: Binding<Item>;
	let content: () -> Content;
	
	@AppStorage("font") var font: String = "JetBrains Mono"
	
	init(
		items: [Item],
		selection: Binding<Item>,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.items = items;
		self.selection = selection;
		self.content = content;
	}
	
	var body: some View {
		HStack(spacing: 0) {
			VStack(spacing: 10) {
				ForEach(items) { item in
					Button(
						action: {
							selection.wrappedValue = item;
						},
						label: {
							HStack {
								ZStack {
									RoundedRectangle(cornerRadius: 6, style: .continuous)
										.fill(Color(NSColor.controlBackgroundColor))
									
									Image(systemName: item.systemImage)
										.imageScale(.medium)
										.foregroundStyle(.primary)
								}
								.frame(width: 24, height: 24)
								
								Text(item.title)
							}
							.font(.custom(font, size: 15))
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(.clear)
							.padding(.all,5)
						}
					)
					.buttonStyle(.borderless)
					.background(Color(NSColor(calibratedHue: NSColor.controlAccentColor.usingColorSpace(.deviceRGB)?.hueComponent ?? 0, saturation: selection.wrappedValue == item ? 0.5 : 0.0, brightness: 0.5, alpha: 0.5)))
					.clipShape(.rect(cornerRadius: 12))
					.lineLimit(1)
				}
			}
			.padding(.all,10)
			.frame(
				minWidth: 200,maxWidth: 200,
				minHeight: 200,maxHeight: .infinity,
				alignment: .top
			)
			.background(.ultraThinMaterial)
			
			Group {
				content()
			}
		}
	}
}
