//
//  UserView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 21/7/24.
//

import SwiftUI

struct UserView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = UserViewViewModel()
    var username: String
    @State var displayReport: Bool = false
    @State var showAlert: Bool = false
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    var body: some View {
        
        ScrollView {
            HStack {
                Spacer()
                
                if let profileString = firebaseManager.groupMembersAvatars[username] {
                    MapMarker(profileString: profileString, username: username, frameWidth: 75, circleWidth: 250, lineWidth: 8, paddingPic: 20)
                }
                
                Spacer()
            }
            .padding()
            
            Text(firebaseManager.usernameToName[username] ?? username)
                .font(.custom("Nunito", size: 34))
                .fontWeight(.black)
                .foregroundStyle(.mainBlue)
            
            
            Text(username)
                .font(.custom("Nunito", size: 24))
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            
            HStack {
                Text(LocalizedStringKey("Umbrellas In Common"))
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            .padding([.top, .horizontal])
            
            ForEach(firebaseManager.userGroups.keys.sorted(), id: \.self) { groupId in
                
                if ((firebaseManager.groupMembers[groupId]?.contains(username)) != nil && (firebaseManager.groupMembers[groupId]?.contains(username)) != false) {
                    UmbrellaListView(groupId: groupId)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 6).foregroundStyle(Color.mainBlue))
                        .padding([.horizontal, .bottom])
                }
            }
            
            Spacer()
            
            HStack {
                
                Button {
                    displayReport.toggle()
                } label: {
                    HStack {
                        Text(LocalizedStringKey("Report User"))
                            .font(.custom("Nunito", size: 18))
                            .bold()
                    
                        Spacer()
                        
                        Image(systemName: "exclamationmark.bubble.fill")
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).fill(.red))
                }
                
                
                Button {
                    showAlert.toggle()
                } label: {
                    HStack {
                        Text(LocalizedStringKey("Block User"))
                            .font(.custom("Nunito", size: 18))
                            .bold()
                    
                        Spacer()
                        
                        Image(systemName: "hand.raised.slash.fill")
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).fill(.red))
                }
                
            }
            .padding()
        }
        .sheet(isPresented: $displayReport, content: {
            ReportView(isPresented: $displayReport, sender: FirebaseManager.shared.currentUserUsername, reported: username)
        })
        .alert(LocalizedStringKey("Block User?"), isPresented: $showAlert) {
            Button(LocalizedStringKey("Block"), role: .destructive) {
                viewModel.blockUser(blockedUser: username)
            }
            Button(LocalizedStringKey("Cancel"), role: .cancel) { }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
           ToolbarItem(placement: .topBarLeading) {
                   Button(action: {
                       dismiss()
                   }) {
                    Label {
                        Text(LocalizedStringKey("Back"))
                    } icon: {
                        Image(.backArrow)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    UserView(username: "dianamoyalapeira")
}
