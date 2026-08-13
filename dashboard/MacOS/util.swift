//
//  util.swift
//  dmcre
//
//  Created by Lilith on 04.04.26.
//

import SwiftUI

func hex(_ value: Int64, width: Int) -> String {
	let s = String(value, radix: 16).uppercased();
	return String(repeating: "0", count: max(0, width - s.count)) + s;
}
