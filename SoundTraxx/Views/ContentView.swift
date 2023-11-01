//
//  ContentView.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewController: ViewController
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Hello, world!")
            
            
            HStack {
                Button("Init Listener") {
                    viewController.network.setupListener(viewController)
                }
                Button("Init Client") {
                    viewController.network.setupClient()
                }
                Button("Connect Client") {
                    viewController.network.connectClient()
                }
            }
            
            Button("Send Message") {
                viewController.sendMessage()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
