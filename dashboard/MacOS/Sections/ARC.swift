//
//  ARC.swift
//  dmcre
//
//  Created by Lilith on 04.04.26.
//

import SwiftUI
import Combine
import Charts

class ARCObject: Identifiable {
	var dataType: String = "";
	var dataSize: Int64 = 0;
	var controlAddress: Int64 = 0;
	var dataAddress: Int64 = 0;
	
	var id: String { String(controlAddress) };
}

class ARCReference: Identifiable {
	var refAddress: Int64 = 0;
	var controlAddress: Int64 = 0;
	
	var id: String { String(controlAddress) };
}

class ARCData: ObservableObject {
	@Published var Objects: [ARCObject] = [];
	@Published var References: [ARCReference] = [];

	func onMessage(message: [String: Any]) {
		if(message["event"] as? String == "ARC/object/create") {
			let Object = ARCObject();
			Object.dataType = message["dataType"] as! String;
			Object.dataSize = message["dataSize"] as! Int64;
			Object.dataAddress = message["dataAddress"] as! Int64;
			Object.controlAddress = message["controlAddress"] as! Int64;

			DispatchQueue.main.async {
				self.Objects.append(Object);
			}
		}
		else if(message["event"] as? String == "ARC/object/destroy") {
			let controlAddress = message["controlAddress"] as! Int64;

			DispatchQueue.main.async {
				self.Objects.removeAll(where: { object in
					return object.controlAddress == controlAddress;
				});
			}
		}
		else if(message["event"] as? String == "ARC/ref/create") {
			let Reference = ARCReference();
			Reference.refAddress = message["refAddress"] as! Int64;
			Reference.controlAddress = message["controlAddress"] as! Int64;
			
			DispatchQueue.main.async {
				self.References.append(Reference);
			}
		}
		else if(message["event"] as? String == "ARC/ref/destroy") {
			let refAddress = message["refAddress"] as! Int64;
			
			DispatchQueue.main.async {
				self.References.removeAll(where: { reference in
					return reference.refAddress == refAddress;
				});
			}
		}
	}
}

struct ARCView: View {
	@StateObject var data: ARCData
	
	enum NavItem: CaseIterable, NavigationItem {
		case Objects
		case References
		case Overview
		case RefTreeGraph
		
		var id: String { title }
		
		var title: String {
			switch self {
				case .Objects:
					return "Objects"
				case .References:
					return "References"
				case .Overview:
					return "Overview"
				case .RefTreeGraph:
					return "Refrence Graph"
			}
		}
		
		var systemImage: String {
			switch self {
				case .Objects:
					return "list.triangle"
				case .References:
					return "link"
				case .Overview:
					return "chart.pie.fill"
				case .RefTreeGraph:
					return "point.3.filled.connected.trianglepath.dotted"
			}
		}
	}
	@State private var navSelection: NavItem = .Objects

	@AppStorage("font") var font: String = "JetBrains Mono"
	
	var body: some View {
		TopTabNavigation(items: NavItem.allCases,selection: $navSelection) {
			// MARK: objects
			if(navSelection == .Objects) {
				Table(data.Objects) {
					TableColumn("data type") { object in
						Text(object.dataType)
							.foregroundStyle(Color.green)
					}
					
					TableColumn("control address") { object in
						Text("0x" + hex(object.controlAddress,width: 16))
							.foregroundStyle(Color.pink)
					}
					
					TableColumn("data address") { object in
						Text("0x" + hex(object.dataAddress,width: 16))
							.foregroundStyle(Color.purple)
					}
					
					TableColumn("data size") { object in
						Text(String(object.dataSize))
							.foregroundStyle(Color.red)
					}
				}
				.frame(maxWidth: .infinity, alignment: .topLeading)
			}
			// MARK: references
			else if(navSelection == .References) {
				Table(data.References) {
					TableColumn("data type") { reference in
						Text(
							data.Objects.first(where: { object in
								return object.controlAddress == reference.controlAddress
							})?.dataType ?? "<dangling reference>"
						)
						.foregroundStyle(Color.green)
					}

					TableColumn("control address") { reference in
						Text("0x" + hex(reference.controlAddress,width: 16))
							.foregroundStyle(Color.pink)
					}
					
					TableColumn("reference address") { reference in
						Text("0x" + hex(reference.refAddress,width: 16))
							.foregroundStyle(Color.purple)
					}
				}
				.frame(maxWidth: .infinity, alignment: .topLeading)
			}
			// MARK: overview
			else if(navSelection == .Overview) {
				let UniqueTypes = Set(data.Objects.map { $0.dataType }).map {$0};

				ScrollView {
					VStack(alignment: .leading, spacing: 50) {
						VStack(spacing: 20) {
							HStack {
								Text("Total size of ARC objects: ")
								Text(
									String(
										data.Objects.reduce(0, { sum, item in
											return sum + item.dataSize
										})
									)+" bytes"
								)
							}
							
							HStack {
								Text("Total number of ARC objects: ")
								Text(String(data.Objects.count))
							}
						}
						.font(.custom(font,size: 14))
						
						VStack(spacing: 100) {
							Chart(
								UniqueTypes,
								id: \.self
							) { type in
								BarMark(
									x: .value("Number of objects", data.Objects.filter({ object in return object.dataType == type}).count),
									y: .value("Type", type)
								)
								.foregroundStyle(by: .value("Type", type))
							}
							.chartLegend(.hidden)
							.frame(
								height: CGFloat(UniqueTypes.count) * 50
							)
							
							Chart(
								UniqueTypes,
								id: \.self
							) { type in
								BarMark(
									x: .value("Combined size of objects",
											  data.Objects.filter({ object in
												  return object.dataType == type
											  }).reduce(0, { sum, object in
												  return sum + object.dataSize
											  })
											 ),
									y: .value("Type", type)
								)
								.foregroundStyle(by: .value("type", type))
							}
							.chartLegend(.hidden)
							.frame(
								height: CGFloat(UniqueTypes.count) * 50
							)
						}
					}
				}
				.background(Color(NSColor.windowBackgroundColor))
				.frame(
					maxWidth: .infinity,maxHeight: .infinity,
					alignment: .topLeading
				)
			}
			// MARK: reference tree graph
			else if(navSelection == .RefTreeGraph) {
				ScrollView {
				}
				.background(Color(NSColor.windowBackgroundColor))
				.frame(
					maxWidth: .infinity,maxHeight: .infinity,
					alignment: .topLeading
				)
			}
		}
	}
}
