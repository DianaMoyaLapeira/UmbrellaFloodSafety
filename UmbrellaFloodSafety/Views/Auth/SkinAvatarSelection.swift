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
    
    let mouth1 = ["mouth1", "mouth2", "mouth3", "mouth4"]
    
    let mouth2 = ["mouth5"]
    
    var body: some View {
        ScrollView {
            
            HStack {
                Text(LocalizedStringKey("Skin Color"))
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 15)]) {
                
                ForEach(skinColors1 + skinColors2 + skinColors3, id: \.self) { skinColor in
                    Button {
                        viewModel.skin = skinColor.replacingOccurrences(of: "Color", with: "")
                    } label: {
                        Circle()
                            .foregroundColor(Color(skinColor))
                    }
                }
            }
            
            HStack {
                
                Text(LocalizedStringKey("Blush"))
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
                
                if viewModel.blush != "" {
                    
                    Button {
                        viewModel.blush = ""
                    } label: {
                        Text(LocalizedStringKey("Remove"))
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.mainBlue)
                    }
                }
                    
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 15)]) {
                ForEach(blushColors, id: \.self) { blushColor in
                    
                    Button {
                        viewModel.blush = blushColor.replacingOccurrences(of: "Color", with: "")
                    } label: {
                        Circle()
                            .foregroundStyle(Color(blushColor))
                    }
                }
            }

            HStack {
                
                Text(LocalizedStringKey("Mouth"))
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
                    
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 20)]) {
                ForEach(mouth1 + mouth2, id: \.self) { mouth in
                    
                    Button {
                        viewModel.mouth = mouth
                    } label: {
                        Image(mouth)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 70)
                            .padding(.top, 7)
                            .scaleEffect(4)
                            .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.quinary))
                    }
                    .foregroundStyle(.primary)
                }
                
            }
            .padding(.leading, 5)
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    SkinAvatarSelection()
}
