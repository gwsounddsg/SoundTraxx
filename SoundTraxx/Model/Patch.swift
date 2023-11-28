//
//  Patch.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 11/2/23.
//

import Foundation


struct Patch: Identifiable, Hashable {
    let id = UUID()
    let objectNumber: Int
    var text: String = ""
}
