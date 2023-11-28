//
//  PatchView.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 11/3/23.
//

import SwiftUI


struct PatchView: View {
    @Binding var data: Patch
    
    var body: some View {
        HStack(spacing: 0) {
            Button {

            } label: {
                Image(systemName: "xmark")
            }

            Label("\(data.objectNumber)", systemImage: "")
                .fontDesign(.monospaced)
                .frame(width: 33, alignment: .trailing)

            TextField("Something", text: $data.text, axis: .horizontal)
                .frame(minWidth: 50, maxWidth: 150)
                .autocorrectionDisabled(true)
                .padding(.leading, 2)
        }
    }
}





struct PatchViewExample: View {
    @State var myText = Patch(objectNumber: 42)

    var body: some View {
        PatchView(data: $myText)
    }
}


struct PatchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PatchViewExample()
        }
    }
}
