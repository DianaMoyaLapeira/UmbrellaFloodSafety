//
//  TextMessageView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/7/24.
//

import SwiftUI

struct TextMessageView: View {
    
    var senderId: String = "hola123"
    var body: some View {
        
        if senderId == FirebaseManager.shared.currentUserUsername {
            HStack {
                Spacer()
                
                Text("Text Message")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 25, bottomLeading: 25, topTrailing: 25)).foregroundStyle(Color.mainBlue))
                
            }
            .padding([.trailing, .bottom])
        } else {
            HStack {
                Text("Text Message")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 25, bottomTrailing: 25, topTrailing: 25)).foregroundStyle(Color.gray.opacity(0.2)))
                
                Spacer()
            }
            .padding([.leading, .bottom])
        }
    }
}

#Preview {
    TextMessageView()
}
