//
//  ShirtSelection.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import SwiftUI

struct ShirtSelection: View {
    
    @ObservedObject var viewModel = CreateAvatarViewViewModel.shared
    
    let shirt1 = ["shirt1", "shirt2", "shirt3"]
    
    let shirt2 = ["shirt4", "shirt5", "shirt6"]
    
    let shirt3 = ["shirt7", "shirt8", "shirt9"]
    
    var body: some View {
        
        ScrollView {
            Grid {
                
                GridRow {
                    ForEach(shirt1, id: \.self) { shirt in
                        
                        Button {
                            viewModel.shirt = shirt
                        } label: {
                            Image(shirt)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 100, alignment: .bottom)
                                .padding(.horizontal, -40)
                                .padding(.bottom)
                        }
                    }
                }.background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.quinary))
                
                GridRow {
                    ForEach(shirt2, id: \.self) { shirt in
                        
                        Button {
                            viewModel.shirt = shirt
                        } label: {
                            Image(shirt)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 100, alignment: .bottom)
                                .padding(.horizontal, -40)
                                .padding(.bottom)
                        }
                    }
                }.background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.quinary))
                
                GridRow {
                    ForEach(shirt3, id: \.self) { shirt in
                        
                        Button {
                            viewModel.shirt = shirt
                        } label: {
                            Image(shirt)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 100, alignment: .bottom)
                                .padding(.horizontal, -40)
                                .padding(.bottom)
                        }
                    }
                }.background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.quinary))
            }
        }
        
        Spacer()
    }
}

#Preview {
    ShirtSelection()
}
