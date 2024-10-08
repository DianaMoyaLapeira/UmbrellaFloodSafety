//
//  MainView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI
import BottomSheet
import _MapKit_SwiftUI

struct MainView: View {
    
    @StateObject private var tabController = TabController()
    @State var showNotificationSheet: Bool = false
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.5)
    @StateObject private var viewModel = MainViewViewModel()
    @StateObject var firebaseManager = FirebaseManager.shared
    @StateObject var mapViewViewModel = MapViewViewModel.shared
    @State var dismissedAlerts: [String] = []
    @State var cameraPosition: MapCameraPosition = .automatic
    let lastLoggedInUsername = UserDefaults.standard.string(forKey: "lastLoggedInUsername")
    
    init() {
    }
    
    var body: some View {
        
        ZStack {
            if firebaseManager.isSignedIn && (UserDefaults.standard.string(forKey: "avatar") != "skin11,shirt1,black,mouth1,,no") && (UserDefaults.standard.string(forKey: "avatar") != nil) {
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
                
                if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation == .landscapeRight || UIDevice.current.orientation == .landscapeLeft {
                    HStack {
                        NavigationSplitView {
                            MapViewSheet(cameraPosition: $cameraPosition)
                        } detail: {
                            MapView(cameraPosition: $cameraPosition, showNotificationSheet: $showNotificationSheet)
                                .toolbar {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Text("Hello \(FirebaseManager.shared.currentUserName)")
                                            .font(.custom("Nunito", size: 34))
                                            .fontWeight(.black)
                                            .foregroundStyle(.mainBlue)
                                    }
                                    
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button {
                                            showNotificationSheet.toggle()
                                        } label: {
                                            Image(systemName: "bell")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundStyle(Color.mainBlue)
                                        }
                                    }
                                }
                        }
                    }
                    .tabItem {
                        Label("", systemImage: "map")
                    }
                    .tag(Tab.map)
                } else {
                    MapView(cameraPosition: $cameraPosition, showNotificationSheet: $showNotificationSheet)
                        .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, switchablePositions: [
                            .relative(0.20),
                            .relative(0.5),
                            .relativeTop(0.80)]) {
                                MapViewSheet(cameraPosition: $cameraPosition)
                            }
                            .customBackground(
                                Color.white.cornerRadius(20)
                            )
                            .tabItem {
                                Label("", systemImage: "map")
                            }
                            .tag(Tab.map)
                }
                
                MessagingView()
                    .tabItem {
                        Label("", systemImage: "message")
                    }
                    .tag(Tab.messages)
                
                LearnView()
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
                        return "flood watch/advisory"
                    } else {
                        return "flood warning"
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
