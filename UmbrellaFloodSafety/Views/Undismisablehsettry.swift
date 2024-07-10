//
//  Undismisablehsettry.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 4/7/24.
//

import SwiftUI

struct Undismisablehsettry: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Undismissible Sheet")
                    .font(.largeTitle)
                    .padding()
                
                // Add other content here
                // to fill the sheet
                
                Button("Close Sheet") {
                    // Perform any necessary actions before allowing dismissal
                    isPresented = false
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .background(Color.black.opacity(0.5).ignoresSafeArea())
    }
}


