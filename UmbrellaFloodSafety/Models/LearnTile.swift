//
//  LearnTile.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/7/24.
//

import SwiftUI

struct LearnTile: View {
    var body: some View {
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        .fill(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: .accentGreen, location: 0.75),
                    Gradient.Stop(color: .white, location: 0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom))
        .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(.mainBlue))
        .frame(height: 250)
        .padding()
        
        VStack {
            Image(.umbrellaLogo)
                .resizable()
                .scaledToFit()
                .padding()
            Text("Lesson Name")
                .font(.custom("Nunito", size: 24))
                .fontWeight(.black)
                .foregroundStyle(.mainBlue)
                .padding(.bottom)
        }
        .frame(width: 350, height: 250)
        .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(.mainBlue))
        
            
    }
}

#Preview {
    LearnTile()
}
