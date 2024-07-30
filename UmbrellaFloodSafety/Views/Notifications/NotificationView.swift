//
//  NotificationView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 17/7/24.
//

import SwiftUI

struct NotificationView: View {
    
    @ObservedObject var viewModel = NotificationViewViewModel.shared
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @Binding var isShown: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isShown = isPresented
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Notifications")
                    .font(.custom("Nunito", size: 32))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
                
                Button {
                    isShown.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                
                if !viewModel.notifications.isEmpty {
                    ForEach(viewModel.notifications) { notification in
                        SingleNotificationView(title: notification.title, username: notification.username, content: notification.content, timestamp: notification.id)
                    }
                    
                } else {
                    Image(.conversationEmptyState)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Notifications will appear if any group member is in a flood hazard area.")
                        .font(.custom("Nunito", size: 18))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
            }
            .onAppear {
                viewModel.getRiskNotifications()
            }
        }
        .frame(width: 390)
        .padding([.horizontal, .top])
    }
}

#Preview {
    struct NotificationViewContainer: View {
        @State private var isPresented = false
        
        var body: some View {
            NotificationView(isPresented: $isPresented)
        }
    }
    
    return NotificationViewContainer()
}
