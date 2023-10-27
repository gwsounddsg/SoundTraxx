//
//  LoggingScene.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/26/23.
//

import SwiftUI



struct LoggingScene: Scene {
    @StateObject var viewController: ViewController

    var body: some Scene {
        Window("Logging", id: "logging") {
            
            LoggingView()
                .environmentObject(viewController)
        }
        .defaultPosition(.topTrailing)
        .defaultSize(width: 300, height: 300)
        .windowResizability(.contentSize)
        .keyboardShortcut("l", modifiers: [.command])
    }
//    var body: some Scene {
//        Window("Logging", id: "logging") {
//            VStack {
//                Text("Here's some logs")
//                    .frame(minWidth: 300, maxWidth: 400, minHeight: 300, maxHeight: .infinity)
//
//            }
//            .padding()
//            .environmentObject(viewController)
//        }
//        .defaultPosition(.topTrailing)
//        .defaultSize(width: 300, height: 300)
//        .windowResizability(.contentSize)
//        .keyboardShortcut("l", modifiers: [.command])
//    }
    
}
