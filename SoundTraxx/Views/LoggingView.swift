//
//  LoggingView.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import SwiftUI



struct LoggingView: View {
    @EnvironmentObject var viewController: ViewController
    
    var body: some View {
        VStack {
            Text("\(viewController.log.data)")
                .frame(minWidth: 300, maxWidth: 400, minHeight: 300, maxHeight: .infinity)
                
        }
        .padding()
        .environmentObject(viewController)
    }
}

struct LoggingView_Previews: PreviewProvider {
    static var previews: some View {
        LoggingView()
    }
}
