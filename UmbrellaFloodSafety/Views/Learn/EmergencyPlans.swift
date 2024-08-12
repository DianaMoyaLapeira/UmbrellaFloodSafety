//
//  EmergencyPlans.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/8/24.
//

import SwiftUI

struct EmergencyPlans: View {
    
    @ObservedObject var emergencyPlanFirebaseManager = EmergencyPlanFirebaseManager.shared
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
                    
                    NavigationLink(destination: EmergencyPlanView(emergencyPlan: emergencyPlanFirebaseManager.emergencyPlans[plan]!)) {
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
                    .padding(.bottom)
                    
                    Divider()
                }
            }
            .padding()
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
        .padding()
    }
}

#Preview {
    EmergencyPlans()
}
