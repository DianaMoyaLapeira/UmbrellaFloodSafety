//
//  LearnTileStroke.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import SwiftUI

import SwiftUI

struct LearnTileStroke: View {
    
    var accentColor: Color
    
    var body: some View {
        
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 8)
                .foregroundStyle(.mainBlue)
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.yellow)
                .frame(width: 320, height: 160)
                //.overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 8).foregroundStyle(.mainBlue))
                .padding(.top)
            
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.red)
                .frame(width: 120)
                .padding(.top, 35)
            
            VStack {
                Spacer()
                
                HStack {
                    Text("Make an Emergency Plan")
                        .foregroundStyle(.mainBlue)
                        .font(.custom("Nunito", size: 32))
                        .fontWeight(.black)
                        .padding(.top, -60)
                    
                    Spacer()
                }
                .padding([.horizontal, .bottom])
            }
        }
        .frame(width: 350, height: 300)
            
    }
}

#Preview {
    LearnTileStroke(accentColor: .accentGreen)
}
