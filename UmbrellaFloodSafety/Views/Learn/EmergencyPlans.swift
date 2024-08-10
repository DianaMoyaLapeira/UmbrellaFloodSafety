//
//  EmergencyPlans.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/8/24.
//

import SwiftUI

struct EmergencyPlans: View {
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
            
            HStack {
                VStack {
                    HStack {
                        Text("Familia's Emergency Plan")
                            .font(.custom("Nunito", size: 24))
                            .fontWeight(.black)
                            .foregroundStyle(.mainBlue)
                        
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
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(.mainBlue))
            .frame(width: 355)
            .padding(.vertical)
            
            Divider()
            
            NavigationLink(destination: MakeEmergencyPlan()) {
                
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
