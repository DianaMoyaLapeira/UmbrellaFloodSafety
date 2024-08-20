//
//  ShirtSelection.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import SwiftUI

struct ShirtSelection: View {
    
    @ObservedObject var viewModel = CreateAvatarViewViewModel.shared
    @State private var opacity: Double = 0
    @State private var scale: Bool = false
    
    let shirt1 = ["shirt1", "shirt2", "shirt3"]
    
    let shirt2 = ["shirt4", "shirt5", "shirt6"]
    
    let shirt3 = ["shirt7", "shirt8", "shirt9"]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 30)]) {
                
                ForEach(shirt1 + shirt2 + shirt3, id: \.self) { shirt in
                    Button {
                        viewModel.shirt = shirt
                    } label: {
                        Image(shirt)
                            .resizable()
                            .scaledToFit()
                            .frame(alignment: .bottom)
                            .padding(.horizontal, -40)
                            .padding(.bottom)
                            .scaleEffect(scale ? 1.2 : 1.0)
                    }
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            scale.toggle()
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.quinary))
                }
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                opacity = 1
            }
        }
    }
}

#Preview {
    ShirtSelection()
}
