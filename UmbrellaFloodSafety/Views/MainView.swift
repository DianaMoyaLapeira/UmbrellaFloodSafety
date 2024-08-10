//
//  MainView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI
import BottomSheet

struct MainView: View {
    
    @State var refreshtrigger: Bool = false
    @StateObject private var tabController = TabController()
    @State var groupSelection = GroupSelection.shared
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.5)
    @StateObject var viewModel = MainViewViewModel()
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @State var isSheetPresented = true
    @StateObject var mapViewViewModel = MapViewViewModel.shared
    
    init() {
    }
    
    var body: some View {
        if firebaseManager.isSignedIn {
            // signed in
            accountView
                .transition(.opacity)
        } else {
            StartView()
                .transition(.opacity)
        }
    }
    
    @ViewBuilder
    var accountView: some View {
       
        TabView(selection: $tabController.activeTab) {
            MapView(username: viewModel.currentUserUsername)
                .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, switchablePositions: [
                        .relative(0.20),
                        .relative(0.5),
                        .relativeTop(0.80)
                    ] ) {
                        
                        MapViewSheet()
                    }
                    .customBackground(
                        Color.white.cornerRadius(20)
                    )
                .tabItem {
                    Label("", systemImage: "map")
                }
                .tag(Tab.map)
            
            MessagingView()
                .tabItem {
                    Label("", systemImage: "message")
                }
                .tag(Tab.messages)
            
            LearnView(username: viewModel.currentUserUsername)
                .tabItem {
                    Label("", systemImage: "book")
                }
                .tag(Tab.learn)
            
            ProfileView(username: viewModel.currentUserUsername)
                .tabItem {
                    Label("", systemImage: "person")
                }
                .tag(Tab.profile)
        }
        .environmentObject(tabController)
    }
}

#Preview {
    MainView()
}
