//
//  SoundTraxxApp.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import SwiftUI

@main
struct SoundTraxxApp: App {
    @StateObject var viewController = ViewController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 200, maxWidth: 400, minHeight: 100, maxHeight: 400)
                .environmentObject(viewController)
        }
        .defaultSize(width: 200, height: 100)
        .windowResizability(.contentSize)
        
        LoggingScene(viewController: viewController)
        
    }
}
