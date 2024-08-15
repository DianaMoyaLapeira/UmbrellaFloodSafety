//
//  EmergencyPlans.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/8/24.
//

import SwiftUI

struct EmergencyPlans: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var emergencyPlanFirebaseManager = EmergencyPlanFirebaseManager.shared
    @State private var opacity: Double = 0
    
    var body: some View {
        ScrollView {
  
            HStack {
                Text("My Emergency Plans")
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            Divider()
            
            VStack {
                
                ForEach(emergencyPlanFirebaseManager.emergencyPlans.keys.sorted(), id: \.self) { plan in
                    
                    NavigationLink(destination: EmergencyPlanView(emergencyPlanId: plan)) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(emergencyPlanFirebaseManager.emergencyPlans[plan]?.title ?? "Emergency Plan")
                                        .font(.custom("Nunito", size: 24))
                                        .fontWeight(.black)
                                    
                                    Spacer()
                                    
                                }
                                
                                HStack {
                                    Text("Tap here to go to plan")
                                        .font(.custom("Nunito", size: 18))
                                    
                                    Spacer()
                                }
                            }
                            
                            Image(systemName: "chevron.right")
                            
                            Spacer()
                        }
                    }
                    .foregroundStyle(.primary)
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(.mainBlue))
            .frame(width: 355)
            .padding(.vertical)
            
            Divider()
            
            NavigationLink(destination: MakeEmergencyPlan(emergencyPlan: nil)) {
                
                HStack {
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundStyle(.mainBlue)
                        .scaledToFit()
                        .frame(width: 24)
                    
                    Text("Make New")
                        .font(.custom("Nunito", size: 24))
                        .bold()
                        .foregroundStyle(.mainBlue)
                    
                    Spacer()
                }
                .padding()
                
            }
            
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                opacity = 1
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18)
                }
            }
        }
    }
}

#Preview {
    EmergencyPlans()
}
