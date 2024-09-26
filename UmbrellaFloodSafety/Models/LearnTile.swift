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
            
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(secondaryColor)
                        .padding([.top, .horizontal])
                        .frame(height: 130)
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(iconColor)
                        .frame(width: 90)
                        .padding(.top)
                }
                
                Text(LocalizedStringKey(title))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                    .font(.custom("Nunito", size: 32))
                    .fontWeight(.black)
                    .padding([.bottom, .horizontal])
            }
        }
        .frame(height: 190)
            
    }
}

#Preview {
    LearnTile(title: "Planes de emergencia", icon: "exclamationmark.triangle", mainColor: .mainBlue, secondaryColor: .accentYellow, iconColor: .red)
}
