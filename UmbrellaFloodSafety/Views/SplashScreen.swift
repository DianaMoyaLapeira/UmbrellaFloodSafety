//
//  SplashScreen.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/12/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
        VStack {
            Image(.umbrellaLogo)
                .resizable()
                .scaledToFit()
                .padding(100)
        }
        
    }
}

#Preview {
    SplashScreen()
}
