//
//  AccessoriesSelection.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import SwiftUI

struct AccessoriesSelection: View {
    
    @ObservedObject var viewModel = CreateAvatarViewViewModel.shared
    
    var body: some View {
        
        HStack {
            Text(LocalizedStringKey("Glasses"))
                .font(.custom("Nunito", size: 24))
                .fontWeight(.black)
                .foregroundStyle(.mainBlue)
            
            Spacer()
            
            if viewModel.accessories != "" {
                Button {
                    viewModel.accessories = ""
                } label: {
                    Text(LocalizedStringKey("Remove"))
                        .font(.custom("Nunito", size: 18))
                        .fontWeight(.black)
                }
            }
        }
        .padding([.horizontal, .top])
        
        HStack {
            
            Button {
                viewModel.accessories = "glasses"
            } label: {
                ZStack {
                    
                    Image(viewModel.hairBack)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160, alignment: .top)
                        .padding(.horizontal, -20)
                    
                    Image(viewModel.skin)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160, alignment: .top)
                        .padding(.horizontal, -20)
                    
                    Image(viewModel.shirt)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160, alignment: .top)
                        .padding(.horizontal, -20)
                    
                    Image(viewModel.hairFront)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160, alignment: .top)
                        .padding(.horizontal, -20)
                    
                    Image(.glasses)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160, alignment: .top)
                        .padding(.horizontal, -20)
                }
            }
            .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.quinary))
            
            Spacer()
        }
        .padding(.leading)
        
        Spacer()
    }
}

#Preview {
    AccessoriesSelection()
}
