//
//  SkinAvatarSelection.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import SwiftUI

struct SkinAvatarSelection: View {
    
    @ObservedObject var viewModel = CreateAvatarViewViewModel.shared
    
    @State var skinSelection: String = ""
    
    let skinColors1 = ["skinColor5", "skinColor4", "skinColor3", "skinColor2", "skinColor1"]
    
    let skinColors2 = ["skinColor6", "skinColor7", "skinColor8", "skinColor9", "skinColor10"]
    
    let skinColors3 = ["skinColor11", "skinColor12", "skinColor13", "skinColor14", "skinColor15"]
    
    let blushColors = ["blushColor1", "blushColor2", "blushColor3", "blushColor4", "blushColor5"]
    
    var body: some View {
        ScrollView {
            
            HStack {
                Text("Skin Color")
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            Grid {
                
                GridRow {
                    ForEach(skinColors1, id: \.self) { skinColor in
                        
                        Button {
                            viewModel.skin = skinColor.replacingOccurrences(of: "Color", with: "")
                        } label: {
                            Circle()
                                .frame(width: 65)
                                .foregroundStyle(Color(skinColor))
                        }
                    }
                }
                
                GridRow {
                    ForEach(skinColors2, id: \.self) { skinColor in
                        
                        Button {
                            viewModel.skin = skinColor.replacingOccurrences(of: "Color", with: "")
                        } label: {
                            Circle()
                                .frame(width: 65)
                                .foregroundStyle(Color(skinColor))
                        }
                    }
                }
                
                GridRow {
                    ForEach(skinColors3, id: \.self) { skinColor in
                        
                        Button {
                            viewModel.skin = skinColor.replacingOccurrences(of: "Color", with: "")
                        } label: {
                            Circle()
                                .frame(width: 65)
                                .foregroundStyle(Color(skinColor))
                        }
                    }
                }
                
                
                HStack {
                    
                    Text("Blush")
                        .font(.custom("Nunito", size: 24))
                        .fontWeight(.black)
                        .foregroundStyle(.mainBlue)
                    
                    Spacer()
                    
                    if viewModel.blush != "" {
                        
                        Button {
                            viewModel.blush = ""
                        } label: {
                            Text("Remove")
                                .font(.custom("Nunito", size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.mainBlue)
                        }
                    }
                        
                }
                
                GridRow {
                    ForEach(blushColors, id: \.self) { blushColor in
                        
                        Button {
                            viewModel.blush = blushColor.replacingOccurrences(of: "Color", with: "")
                        } label: {
                            Circle()
                                .frame(width: 65)
                                .foregroundStyle(Color(blushColor))
                        }
                    }
                }

            }
            
            Text(skinSelection)
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    SkinAvatarSelection()
}
