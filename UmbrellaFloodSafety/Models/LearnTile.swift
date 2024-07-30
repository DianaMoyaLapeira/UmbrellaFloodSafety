//
//  LearnTile.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/7/24.
//

import SwiftUI

struct LearnTile: View {
    var body: some View {
        
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.mainBlue)
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.yellow)
                .padding(.top)
                .frame(width: 320, height: 170)
            
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.red)
                .frame(width: 120)
                .padding(.top, 35)
            
            VStack {
                Spacer()
                
                HStack {
                    Text("Emergency Help")
                        .foregroundStyle(.white)
                        .font(.custom("Nunito", size: 32))
                        .fontWeight(.black)
                        .padding(.top, -65)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .frame(width: 350, height: 250)
            
    }
}

#Preview {
    LearnTile()
}
