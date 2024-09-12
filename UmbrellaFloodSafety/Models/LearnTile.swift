//
//  LearnTile.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/7/24.
//

import SwiftUI

struct LearnTile: View {
    var title: String
    var icon: String
    var mainColor: Color
    var secondaryColor: Color
    var iconColor: Color
    
    var body: some View {
        
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(mainColor)
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(secondaryColor)
                .padding([.top, .horizontal])
                .frame(height: 170)
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(iconColor)
                .frame(width: 120)
                .padding(.top, 35)
            
            VStack {
                Spacer()
                
                HStack {
                    Text(LocalizedStringKey(title))
                        .foregroundStyle(.white)
                        .font(.custom("Nunito", size: 32))
                        .fontWeight(.black)
                        .padding(.top, -65)
                        .padding()
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 250)
            
    }
}

#Preview {
    LearnTile(title: "Emergency Help", icon: "exclamationmark.triangle", mainColor: .mainBlue, secondaryColor: .accentYellow, iconColor: .red)
}
