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
                .environmentObject(viewController)
        }
        .defaultSize(width: 200, height: 100)
        .windowResizability(.contentSize)
        
        LoggingScene(viewController: viewController)
        
    }
}
