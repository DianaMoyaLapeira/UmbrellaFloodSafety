//
//  ConversationView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/7/24.
//

import SwiftUI

struct ConversationView: View {
    
    @State var textInput: String = ""
    
    var body: some View {
        VStack {
            HStack {
                MapMarker(image: Image(.adultWoman), username: "testadult", frameWidth: 20, circleWidth: 60, lineWidth: 4)
                
                VStack {
                    HStack {
                        Text("name")
                            .font(.custom("Nunito", size: 24))
                            .fontWeight(.black)
                        .foregroundStyle(Color.mainBlue)
                        
                        Spacer()
                    }
                    HStack {
                        Text("familygroup")
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(Color(UIColor.darkGray))
                        
                        Spacer()
                    }
                }
                .padding(.leading)
            }
            .padding()
            
            Divider()
                .padding(.bottom)
            
            ScrollView() {
                
                Spacer()
                
                TextMessageView()
                
                TextMessageView()
            }
            
            HStack {
                TextField("text input", text: $textInput, prompt: Text("Message").font(.custom("Nunito", size: 18)).foregroundStyle(Color.secondary))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(Color.gray.opacity(0.2)))
                    .padding([.leading, .top])
                
             
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.mainBlue)
                    .padding([.leading, .top, .trailing])

            }
        }
    }
}

#Preview {
    ConversationView()
}
