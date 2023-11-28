//
//  ContentView.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var vc: ViewController
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 160, maximum: 300))]
    
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button("Mute") {

                }
                Button("Edit") {

                }
                Button("Log") {
                    vc.printPatch()
                }
            }
            .padding()
            
            Divider()

            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach($vc.patch) { $data in
                        PatchView(data: $data)
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.trailing, 0)
        }
        .padding(.vertical, 12)
        .frame(minWidth: 400, maxWidth: 800, minHeight: 300, maxHeight: 1200)
    }
}





struct ContentViewExample: View {
    @StateObject var vc = ViewController()
    
    var body: some View {
        ContentView()
            .environmentObject(vc)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewExample()
    }
}
