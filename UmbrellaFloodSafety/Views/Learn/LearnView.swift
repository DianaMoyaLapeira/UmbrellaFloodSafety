//
//  LearnView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct LearnView: View {
   
    @StateObject private var firebaseManager = FirebaseManager.shared
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(LocalizedStringKey("Resources"))
                        .font(.custom("Nunito", size: 34))
                        .foregroundStyle(Color.mainBlue)
                        .fontWeight(.black)
                        .padding()
                    
                    Spacer()
                    
                    Call911Button()
                }
                
                Divider()
                
                ScrollView {
                    
                    if firebaseManager.isChild {
                        NavigationLink {
                            KidsEmergencyGuide()
                        } label: {
                            LearnTile(title: "Emergency Help", icon: "exclamationmark.triangle", mainColor: .mainBlue, secondaryColor: .accentYellow, iconColor: .red)
                                .padding()
                        }

                    } else {
                        NavigationLink {
                            AdultEmergencyGuide()
                        } label: {
                            LearnTile(title: "Emergency Help", icon: "exclamationmark.triangle", mainColor: .mainBlue, secondaryColor: .accentYellow, iconColor: .red)
                                .padding()
                        }
                    }
                    
                    NavigationLink {
                        EmergencyPlans()
                    } label: {
                        LearnTile(title: "Emergency Plans", icon: "person.badge.shield.checkmark", mainColor: .mainBlue, secondaryColor: .white.opacity(0.95), iconColor: .accentGreen)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink {
                        BreathingView()
                    } label: {
                        LearnTile(title: "Breathing", icon: "wind", mainColor: .mainBlue, secondaryColor: .white, iconColor: .skyBlue)
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

#Preview {
    LearnView()
}
