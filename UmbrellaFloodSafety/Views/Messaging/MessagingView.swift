//
//  MessagingView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct MessagingView: View {
    @ObservedObject var viewModel = MessagingViewViewModel.shared
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @State var showNotificationSheet: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    Text("Messages")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(Color.mainBlue)
                    
                    Spacer()
                    
                    Button {
                        showNotificationSheet.toggle()
                    } label: {
                        Image(systemName: "bell")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.mainBlue)
                    }
                }
                .padding()
                
                Divider()
                
                if firebaseManager.conversations.count != 0 {
                    ScrollView {
                        ForEach(firebaseManager.conversations.keys.sorted(), id: \.self) { key in
                            NavigationLink(destination: ConversationView(conversationId: key, username: firebaseManager.conversations[key]?.participants ?? [])) {
                                MessagingListItem(participants: firebaseManager.conversations[key]?.participants ?? [], timestamp: firebaseManager.conversations[key]?.lastMessageTimestamp ?? 0.0, lastMessage: firebaseManager.conversations[key]?.lastMessage ?? "")
                                    .padding(.leading)
                            }
                            
                            Divider()
                                .padding([.leading, .trailing])
                        }
                    }
                } else {
                    Image(.messagesEmptyState)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                    
                    Text("No messages yet.\n Try joining an Umbrella in the profile tab!")
                        .multilineTextAlignment(.center)
                        .font(.custom("Nunito", size: 18))
                        .bold()
                }
                
                
                Spacer()
            }
            .sheet(isPresented: $showNotificationSheet, content: {
                NotificationView(isPresented: $showNotificationSheet)
            })
        }
    }
}

#Preview {
    MessagingView()
}
