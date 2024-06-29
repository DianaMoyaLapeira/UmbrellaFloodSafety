//
//  MainView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            accountView
        } else {
            StartView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView{
            MapView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("", systemImage: "map")
                }
            
            MessagingView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("", systemImage: "message")
                }
            
            LearnView(username: viewModel.currentUserUsername)
                .tabItem {
                    Label("", systemImage: "book")
                }
            
            ProfileView(username: viewModel.currentUserUsername)
                .tabItem {
                    Label("", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainView()
}
