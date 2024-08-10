//
//  EmergencyPlanUsers.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/8/24.
//

import SwiftUI

struct EmergencyPlanUsers: View {
    
    @Binding var usersInPlan: [String]
    var planId: String
    @State var isPresented: Bool = false
    var groupMembers = FirebaseManager.shared.groupMembersAvatars.keys.sorted()
    
    var body: some View {
        VStack {
            HStack {
                Text("Who's In This Plan?")
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            Divider()
            
            ScrollView {
                
                if usersInPlan.count != 0 {
                    
                    ForEach(usersInPlan, id: \.self) { member in
                        
                        NavigationLink(destination: UserView(username: member)) {
                            MessagingListItem(participants: [member], timestamp: 0, lastMessage: member)
                        }
                    }
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
                
                Divider()
                
                UMButton(title: "Add Members", background: .mainBlue) {
                    isPresented.toggle()
                }
                .frame(height: 60)
                .padding(.vertical)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            VStack {
                HStack {
                    Text("Add New Members")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(.mainBlue)
                    
                    Spacer()
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                    }
                }
                
                Divider()
                
                ForEach(usersInPlan, id: \.self) {member in
                    
                    Button {
                        
                    } label: {
                        ZStack(alignment: .trailing) {
                            MessagingListItem(participants: [member], timestamp: 0, lastMessage: member)
                            
                            Text("Add")
                                .font(.custom("Nunito", size: 18))
                                .foregroundStyle(.white)
                                .bold()
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 25)
                                    .fill(.mainBlue)
                                    .frame(width: 100, height: 60)
                                )
                                .padding(.horizontal)
                            
                        }
                        
                    }
                }
                Spacer()
            }
            .padding()
        })
    }
}

#Preview {
    struct emergencyPlanUsersViewContainer: View {
        @State private var users = ["user1", "user2"]
        @State private var planId = "hello"
        
        var body: some View {
            EmergencyPlanUsers(usersInPlan: $users, planId: planId)
        }
    }
    
    return emergencyPlanUsersViewContainer()
}

