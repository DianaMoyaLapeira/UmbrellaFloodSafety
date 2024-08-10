//
//  LearnView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct LearnView: View {
    @StateObject var viewModel: LearnViewViewModel
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    init(username: String) {
        self._viewModel = StateObject(wrappedValue: LearnViewViewModel(username: username))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Learn")
                        .font(.custom("Nunito", size: 34))
                        .foregroundStyle(Color.mainBlue)
                        .fontWeight(.black)
                        .padding()
                    
                    Spacer()
                }
                
                Divider()
                
                ScrollView {
                    HStack {
                        Text("Emergency")
                            .font(.custom("Nunito", size: 32))
                            .foregroundStyle(Color.red)
                            .fontWeight(.black)
                            .padding()
                        
                        Spacer()
                    }
                    
                    if firebaseManager.isChild {
                        NavigationLink {
                            KidsEmergencyGuide()
                        } label: {
                            LearnTile(title: "Emergency Help", icon: "exclamationmark.triangle", mainColor: .mainBlue, secondaryColor: .accentYellow, iconColor: .red)
                        }

                    } else {
                        NavigationLink {
                            AdultEmergencyGuide()
                        } label: {
                            LearnTile(title: "Emergency Help", icon: "exclamationmark.triangle", mainColor: .mainBlue, secondaryColor: .accentYellow, iconColor: .red)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Prepare")
                            .font(.custom("Nunito", size: 34))
                            .foregroundStyle(Color.mainBlue)
                            .fontWeight(.black)
                            .padding()
                        
                        Spacer()
                    }
                    
                    NavigationLink {
                        EmergencyPlans()
                    } label: {
                        LearnTile(title: "Emergency Plans", icon: "person.badge.shield.checkmark", mainColor: .mainBlue, secondaryColor: .white.opacity(0.95), iconColor: .accentGreen)
                    }
                }
            }
        }
    }
}

#Preview {
    LearnView(username: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
