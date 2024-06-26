//
//  UMButtonStroke.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct UMButtonStoke: View {
    
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .stroke(Color(background), lineWidth: 4)
                Text(title)
                    .font(.custom("Nunito", size: 18))
                    .bold()
                    .foregroundColor(background)
            }
        }
        
    }
}

#Preview {
    UMButton(title: "Sign Up", background: .mainBlue) {
        //Action
    }
}
