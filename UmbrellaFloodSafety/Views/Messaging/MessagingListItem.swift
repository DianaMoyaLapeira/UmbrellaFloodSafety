//
//  MessagingListItem.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/7/24.
//

import SwiftUI

struct MessagingListItem: View {
    var participants: [String]
    var actualparticipants: [String] {
        if participants.count > 1 {
            participants.filter {
                $0 != FirebaseManager.shared.currentUserUsername
            }
        } else {
            participants
        }
    }
    var participantName: String {
        
        if actualparticipants.count != 0 {
            return FirebaseManager.shared.usernameToName[actualparticipants[0]] ?? ""
        } else {
            return "Name"
        }
    }
    var firstParticipant: String {
        if actualparticipants.count != 0 {
            return actualparticipants[0]
        } else {
            return "first participant"
        }
        
    }
    var timestamp: Double
    var actualtimestamp: String {
        guard timestamp != 0 else {
            return ""
        }
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: timestamp)
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    var lastMessage: String
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    var body: some View {
        if let profileString = firebaseManager.groupMembersAvatars[firstParticipant] {
            VStack {
                HStack {
                    
                    MapMarker(profileString: profileString, username: firstParticipant, frameWidth: 25, circleWidth: 70, lineWidth: 4, paddingPic: 5)
                    
                    VStack {
                        Spacer()
                        HStack {
                            if participantName == "" {
                                Text("\(actualparticipants.joined(separator: ", "))") // username if name is not available
                                    .font(.custom("Nunito", size: 24).bold())
                                    .foregroundStyle(.mainBlue)
                            } else {
                                Text("\(participantName)") // name if available
                                    .font(.custom("Nunito", size: 24).bold())
                                    .foregroundStyle(.mainBlue)
                            }
                            Spacer()
                            
                            if lastMessage != "No messages yet" {
                                Text("\(actualtimestamp)") // time stamp of last message
                                    .font(.custom("Nunito", size: 18))
                                    .foregroundStyle(Color(UIColor.darkGray))
                                
                            }
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(UIColor.darkGray))
                                .padding(.trailing)
                        }
                        
                        HStack {
                            Text("\(lastMessage)") // Last message
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
}

#Preview {
    MessagingListItem(participants: ["testadult"], timestamp: 13434.3, lastMessage: "hello")
}
