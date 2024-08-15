//
//  UmbrellaView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 26/7/24.
//

import SwiftUI

struct UmbrellaView: View {
    
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @Environment(\.dismiss) var dismiss
    let groupId: String
    
    init(groupId: String) {
        self.groupId = groupId
    }
    
    // Information: Name of umbrella, umbrella code, members
    var body: some View {
        VStack {
            HStack {
                Text(firebaseManager.userGroups[groupId] ?? "Umbrella")
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            HStack {
                Text("Umbrella Code: \(groupId)")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.secondary)
                    .bold()
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text("Members")
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            if firebaseManager.groupMembers[groupId]?.count != 0 {
                
                VStack {
                    ForEach(firebaseManager.groupMembers[groupId] ?? [""], id: \.self) { member in
                        
                        if member != "" && member != firebaseManager.currentUserUsername {
                            NavigationLink(destination: UserView(username: member)) {
                                MessagingListItem(participants: [member], timestamp: 0, lastMessage: member)
                            }
                        } else if member == firebaseManager.currentUserUsername {
                            NavigationLink(destination: UserView(username: member)) {
                                MessagingListItem(participants: [firebaseManager.currentUserUsername], timestamp: 0, lastMessage: member)
                            }
                        }
                        
                        Divider()
                    }
                }
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
            } else {
                Image(.umbrellaEmptyState)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Text("No members yet. Add members on their device using the Umbrella Code!")
                    .font(.custom("Nunito", size: 18))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18)
                }
            }
        }
    }
}

#Preview {
    UmbrellaView(groupId: "567316")
}
