//
//  suggestionView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 11/7/24.
//

import SwiftUI

struct suggestionView: View {
    
    var suggestion: String
    
    var body: some View {
        Text(suggestion)
            .font(.custom("Nunito", size: 18))
            .foregroundStyle(Color.mainBlue)
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(Color.mainBlue))
    }
}

#Preview {
    suggestionView(suggestion: "ex suggestion")
}
