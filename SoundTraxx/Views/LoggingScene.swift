//
//  LoggingScene.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/26/23.
//

import Foundation
import SwiftUI



struct LoggingScene: Scene {

    var body: some Scene {
        Window("Logging", id: "logging") {
            VStack {
                Text("Here's some logs")
                    .frame(minWidth: 300, maxWidth: 400, minHeight: 300, maxHeight: .infinity)
                    
            }
            .padding()
        }
        .defaultPosition(.topTrailing)
        .defaultSize(width: 300, height: 300)
        .windowResizability(.contentSize)
        .keyboardShortcut("l", modifiers: [.command])
    }
    
}
