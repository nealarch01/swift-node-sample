//
//  CaptionedTextField.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

struct CaptionedTextField: View {
    let caption: String
    @Binding var text: String
    let placeholder: String
    var body: some View {
        VStack {
            HStack {
                Text(caption)
                    .font(.system(size: 22, weight: .medium))
                    .padding([.leading], 40)
                    .padding([.bottom], -2)
                    .foregroundColor(Color.black)
                Spacer()
            }
            
            TextField(placeholder, text: $text)
                .padding()
                .frame(width: 310, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(12)
                .disableAutocorrection(true)
        }
        .padding([.top, .bottom], 5)
    }
}

struct CaptionedTextField_Previews: PreviewProvider {
    static var previews: some View {
        CaptionedTextField(caption: "", text: .constant(""), placeholder: "")
    }
}
