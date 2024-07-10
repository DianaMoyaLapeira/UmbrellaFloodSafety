//
//  UmbrellaListView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import SwiftUI

struct UmbrellaListView: View {
    
    var firebaseManager = FirebaseManager.shared
    var groupId: String
    var membersOfGroup: String {
        if let members = firebaseManager.groupMembers[groupId] {
            return members.joined(separator: ", ")
        }
        return ("No members yet. Use my code to add some!")
    }
    
    var body: some View {
        NavigationLink(destination: NewUmbrellaView(username: "testadult")) {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text("\( firebaseManager.userGroups[groupId] ?? "Group has no name")")
                                .font(.custom("Nunito", size: 24))
                                .foregroundStyle(.black)
                            .fontWeight(.bold)
                            
                            Spacer()
                        }
                        HStack {
                           
                            Text("Members: \(membersOfGroup)")
                                .font(.custom("Nunito", size: 18))
                                .foregroundStyle(Color(.darkGray))
                            
                            Spacer()
                            
                        }
                        HStack {
                            
                            Text("Group Code: \(groupId)")
                                .font(.custom("Nunito", size: 18))
                                .foregroundStyle(Color(.darkGray))
                            
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding()
                Divider()
            }
        }
    }
}

#Preview {
    UmbrellaListView(groupId: "588217")
}
