//
//  MainView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI
import BottomSheet

struct MainView: View {
    
    @State var groupSelection = GroupSelection.shared
    @State var bottomSheetPosition: BottomSheetPosition = .absolute(325)
    @StateObject var viewModel = MainViewViewModel()
    @State var isSheetPresented = true
    @StateObject var mapViewViewModel = MapViewViewModel.shared
    
    init() {
    }
    
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
       
        TabView() {
            MapView(username: viewModel.currentUserUsername)
                .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, switchablePositions: [
                                                .relative(0.200),
                                                .relative(0.4),
                                                .relativeTop(0.90)
                                            ] ) {
                                                MapViewSheet()
                                            }
                                            .customBackground(
                                                Color.white
                                                                .cornerRadius(20)
                                                                
                                                        )
                .tabItem {
                    Label("", systemImage: "map")
                }
                .toolbarBackground(.visible, for: .tabBar)
            
            MessagingView()
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
