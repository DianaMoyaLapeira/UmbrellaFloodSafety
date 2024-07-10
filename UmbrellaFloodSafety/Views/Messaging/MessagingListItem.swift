//
//  MessagingListItem.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/7/24.
//

import SwiftUI

struct MessagingListItem: View {
    var body: some View {
            VStack {
                HStack {
                    MapMarker(image: Image(.adultWoman), username: "testadult", frameWidth: 25, circleWidth: 70, lineWidth: 3)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Text("Adriana") // user for chat
                                .font(.custom("Nunito", size: 24).bold())
                                .foregroundStyle(.mainBlue)
                            Spacer()
                            Text("3:45") // time stamp of last message
                                .font(.custom("Nunito", size: 18))
                                .foregroundStyle(Color(UIColor.darkGray))
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(UIColor.darkGray))
                                .padding(.trailing)
                        }
                        HStack {
                            Text("Last message") // Last message
                                .font(.custom("Nunito", size: 18))
                                .foregroundStyle(Color(UIColor.darkGray))
                            Spacer()
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                }.frame(height: 100)
        }
    }
}

#Preview {
    MessagingListItem()
}
