//
//  ProfileWMarker.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import SwiftUI

struct ProfileWMarker: View {
    
    
    
    var body: some View {
        ZStack {
            
            Circle()
                .foregroundStyle(Color.white)
                .frame(width: 300, height: 300)
            
            Image(.adultWoman)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 300, height: 300)
            
            
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 80)
                        .foregroundStyle(Color.accentGreen)
                }
            }
        }.frame(width: 300, height: 300)
    }
}

#Preview {
    ProfileWMarker()
}
