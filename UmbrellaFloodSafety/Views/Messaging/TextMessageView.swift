//
//  TextMessageView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/7/24.
//

import SwiftUI

struct TextMessageView: View {
    
    var content: String
    var timestamp: CGFloat
    var actualtimestamp: String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: timestamp)
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    var senderId: String
    var body: some View {
        
        if senderId == FirebaseManager.shared.currentUserUsername {
            HStack {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(content)
                        .font(.custom("Nunito", size: 18))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.trailing)
                    HStack {
                        Text(actualtimestamp)
                            .font(.custom("Nunito", size: 15))
                            .foregroundStyle(Color.white.opacity(0.7))
                    }
                }
                .padding()
                .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 25, bottomLeading: 25, topTrailing: 25)).foregroundStyle(Color.mainBlue))
                
            }
            .padding([.trailing, .bottom])
        } else {
            HStack {
                VStack(alignment: .leading) {
                    Text(content)
                        .font(.custom("Nunito", size: 18))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text(actualtimestamp)
                            .font(.custom("Nunito", size: 15))
                            .foregroundStyle(Color.secondary)
                    }
                }
                .padding()
                .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 25, bottomTrailing: 25, topTrailing: 25)).foregroundStyle(Color.gray.opacity(0.2)))
                
                Spacer()
            }
            .padding([.leading, .bottom])
        }
    }
}

#Preview {
    TextMessageView(content: "test", timestamp: 0.0, senderId: "a")
}
