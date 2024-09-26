//
//  FloodDetectedView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/10/24.
//

import SwiftUI

struct FloodDetectedView: View {
    
    var currentUsername = FirebaseManager.shared.currentUserName
    var usernameToName = FirebaseManager.shared.usernameToName
    @State var opacity: Double = 0
    @State var floodType: String
    @Environment(\.dismiss) var dismiss
    @Binding var dismissedAlerts: [String]
    @Binding var activeTab: Tab
    @State var member: String
    
    var body: some View {
       
        VStack {
            if member == currentUsername {
                Text("It looks like there's a \(floodType) in your area.")
                    .multilineTextAlignment(.center)
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Text("If you feel unsafe, stay away from the water, get to high ground, and check out your emergency plans.")
                    .multilineTextAlignment(.center)
                    .font(.custom("Nunito", size: 18))
            } else {
                Text("It looks like there's a \(floodType) in \(usernameToName[member] ?? member)'s area.")
                    .multilineTextAlignment(.center)
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                Text("Check up on them if you think they might be in danger.")
                    .multilineTextAlignment(.center)
                    .font(.custom("Nunito", size: 18))
            }
            
            if EmergencyPlanFirebaseManager.shared.emergencyPlans.count != 0 {
                UMButton(title: "Emergency Help", background: .mainBlue) {
                    activeTab = .learn
                    dismissedAlerts.append(member)
                }
                .frame(height: 60)
                .padding(.bottom, 4)
            }
        
            if member == currentUsername {
                HStack {
                    Call911Button()
                    UMButton(title: "I'm Safe", background: .mainBlue) {
                        dismissedAlerts.append(member)
                    }
                    .frame(height: 40)
                }
            } else {
                UMButton(title: "Messages", background: .mainBlue) {
                    activeTab = .messages
                    
                    withAnimation {
                        dismissedAlerts.append(member)
                    }
                }
                .frame(height: 60)
                .padding(.bottom, 4)
                
                UMButtonStoke(title: "Ok", background: .mainBlue) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        dismissedAlerts.append(member)
                    }
                }
                .frame(height: 60)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(.white).foregroundStyle(.thickMaterial))
        .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).fill(.mainBlue))
        .padding()
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.2)) {
                opacity = 1
            }
        }
        .onChange(of: dismissedAlerts) { oldVal, newVal in
            if !oldVal.contains(member) && newVal.contains(member) {
                withAnimation(.easeIn(duration: 0.2)) {
                    opacity = 0
                }
            }
        }
    }
}

#Preview {
    struct FloodDetectedViewContainer: View {
        @State private var dismissedAlerts = ["hello"]
        @State private var activeTab = TabController().activeTab
        
        var body: some View {
            FloodDetectedView(floodType: "flood warning", dismissedAlerts: $dismissedAlerts, activeTab: $activeTab, member: "member")
        }
    }
    
    return FloodDetectedViewContainer()
}
