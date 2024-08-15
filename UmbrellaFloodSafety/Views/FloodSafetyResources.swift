//
//  FloodSafetyResources.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 17/7/24.
//

import SwiftUI

struct FloodSafetyResources: View {
    var body: some View {
        
        HStack {
            Link(destination: URL(string: "https://www.unicef.org/parenting/emergencies/flood-safety-information")!, label: {
                Text("UNICEF Flood Safety Information")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.mainBlue)
                    .underline()
            })
            
            Spacer()
        }
        
        HStack {
            Link(destination: URL(string: "https://www.weather.gov/safety/flood")!, label: {
                Text("National Weather Service Flood Safety Tips")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.mainBlue)
                    .underline()
            })
            
            Spacer()
        }
        
        HStack {
            Link(destination: URL(string: "https://www.water.noaa/gov/")!, label: {
                Text("National Water Prediction Service")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.mainBlue)
                    .underline()
            })
            
            Spacer()
        }
        
        HStack {
            Link(destination: URL(string: "https://www.weather.gov/safety/flood-during")!, label: {
                Text("National Weather Service Safety During Floods")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.mainBlue)
                    .underline()
            })
            
            Spacer()
        }
        
        HStack {
            Link(destination: URL(string: "https://www.redcross.org/content/dam/redcross/atg/PDF_s/Preparedness___Disaster_Recovery/General_Preparedness___Recovery/Home/ARC_Family_Disaster_Plan_Template_r083012.pdf")!, label: {
                Text("Red Cross Family Disaster Plan")
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.mainBlue)
                    .underline()
            })
            
            Spacer()
        }
        
        Spacer()
    }
}

#Preview {
    FloodSafetyResources()
}
