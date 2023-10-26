//
//  SoundTraxxApp.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import SwiftUI

@main
struct SoundTraxxApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 100, maxWidth: 400, minHeight: 100, maxHeight: 400)
        }
        .defaultSize(width: 200, height: 100)
        .windowResizability(.contentSize)
        
        LoggingScene()
    }
}
