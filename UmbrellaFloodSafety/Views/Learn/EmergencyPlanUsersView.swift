//
//  EmergencyPlanUsersView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/10/24.
//

import SwiftUI

struct EmergencyPlanUsersView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isPresented: Bool = false
    @State private var opacity: Double = 0
    @Binding var usersInPlan: [String]
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    var body: some View {
        VStack {
            HStack {
                Text("Who's in This Plan?")
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            Divider()
            
            
            ScrollView {
                
                VStack {
                    ForEach(usersInPlan, id: \.self) { member in
                        NavigationLink(destination: UserView(username: member)) {
                            MessagingListItem(participants: [member], timestamp: 0, lastMessage: member)
                        }
                        
                        Divider()
                    }
                    .padding(.horizontal)
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
                .padding(2)
                
                UMButton(title: "Add Members From Umbrellas", background: .mainBlue) {
                    isPresented.toggle()
                }
                .frame(height: 60)
                .padding(.vertical)
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                opacity = 1
            }
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            AddUsersToPlanSheet(usersInPlan: $usersInPlan, isPresented: $isPresented)
        })
    }
}

#Preview {
    struct EmergencyPlanUsersViewContainer: View {
        @State private var exampleUsers = ["user1", "user2"]
        
        var body: some View {
            EmergencyPlanUsersView(usersInPlan: $exampleUsers)
        }
    }
    
    return EmergencyPlanUsersViewContainer()
}

