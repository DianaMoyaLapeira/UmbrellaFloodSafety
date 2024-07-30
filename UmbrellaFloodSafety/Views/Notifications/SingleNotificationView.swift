//
//  SingleNotificationView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 19/7/24.
//

import SwiftUI

struct SingleNotificationView: View {
    
    @ObservedObject var firebaseManager = FirebaseManager.shared
    var title: String
    var username: String
    var content: String
    var timestamp: Double
    var actualtimestamp: String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: timestamp)
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack {
                
                MapMarker(profileString: firebaseManager.groupMembersAvatars[username] ?? "", username: username, frameWidth: 25, circleWidth: 70, lineWidth: 3, paddingPic: 5)
                
                VStack {
                    Spacer()
                    HStack {
                       
                        Text(title) // title of the notification
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("Nunito", size: 24).bold())
                            .foregroundStyle(.mainBlue)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        
                        Text(actualtimestamp ) // time stamp of notification
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(Color(UIColor.darkGray))
                        
                    }
                    
                    HStack {
                        Text(content) // Last message
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("Nunito", size: 18))
                            .multilineTextAlignment(.leading)
                            .frame(width: 200)
                            .foregroundStyle(Color(UIColor.darkGray))
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                
                Spacer()
  
            }
            .padding(.bottom)
            
            Divider()
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    SingleNotificationView(title: "title", username: "username", content: "content", timestamp: 0)
}
