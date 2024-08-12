//
//  MainView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI
import BottomSheet

struct MainView: View {
    
    @StateObject private var tabController = TabController()
    @State private var groupSelection = GroupSelection.shared
    @State private var bottomSheetPosition: BottomSheetPosition = .relative(0.5)
    @StateObject private var viewModel = MainViewViewModel()
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @State private var isSheetPresented = true
    @StateObject var mapViewViewModel = MapViewViewModel.shared
    @State var dismissedAlerts: [String] = []
    
    init() {
    }
    
    var body: some View {
        
        ZStack {
            if firebaseManager.isSignedIn {
                // signed in
                accountView
            } else {
                StartView()
            }
        }
        .transition(.asymmetric(insertion: .slide, removal: .opacity))
        .animation(.easeInOut, value: firebaseManager.isSignedIn)
    }
    
    @ViewBuilder
    var accountView: some View {
       
        ZStack {
            TabView(selection: $tabController.activeTab) {
                MapView()
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
                        .onAppear {
                            //
                        }
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
            
            ForEach(firebaseManager.memberRiskLevels.keys.sorted(), id: \.self) { member in
                
                var floodType: String {
                    if firebaseManager.memberRiskLevels[member] == 1 {
                        return "flood warning/advisory"
                    } else {
                        return "flood watch"
                    }
                }
                
                if !dismissedAlerts.contains(member) {
                    FloodDetectedView(floodType: floodType,
                                      dismissedAlerts: $dismissedAlerts,
                                      activeTab: $tabController.activeTab,
                                      member: member
                    )
                    .transition(.move(edge: .bottom))
                }
               
            }
            
            
        }
        
    }
}

#Preview {
    MainView()
}
