//
//  HairSelection.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import SwiftUI

struct HairSelection: View {
    
    let hairColors1 = ["blackHair", "darkBrownHair", "lightBrownHair", "darkGingerHair", "gingerHair"]
    
    let hairColors2 = ["darkBlonde", "lightBlonde"]
    
    let shortStyles = ["short4", "short5", "short6", "short7", "short8",
                       "short1", "short2", "short3"]
    
    let frontStyles = ["front1", "front2", "front3", "front4", "front5"]
    
    let backStyles = ["back1", "back2", "back3", "back4", "back5"]
    
    
    var coloredShortStyles: [String] {
        
        var arrayShortHair: [String] = []
        
        for style in shortStyles {
            arrayShortHair.append(viewModel.hairColor + style)
        }
        
        return arrayShortHair
    }
    
    var coloredFrontStyles: [String] {
        
        var arrayFrontHair: [String] = []
        
        for style in frontStyles {
            arrayFrontHair.append(viewModel.hairColor + style)
        }
        
        return arrayFrontHair
    }
    
    var coloredBackStyles: [String] {
        
        var arrayBackHair: [String] = []
        
        for style in backStyles {
            arrayBackHair.append(viewModel.hairColor + style)
        }
        
        return arrayBackHair
    }
    
    @ObservedObject var viewModel = CreateAvatarViewViewModel.shared
    
    var body: some View {
        ScrollView {
            
            HStack {
                Text("Hair Color")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(Color.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
                if viewModel.hairFront != "" {
                    Button {
                        viewModel.hairFront = ""
                        viewModel.hairBack = ""
                    } label: {
                        Text("Remove")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.black)
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                ForEach(hairColors1, id: \.self) { haircolor in
                    Button {
                        viewModel.hairColor = haircolor.replacingOccurrences(of: "Hair", with: "").lowercased()
                    } label : {
                        Circle()
                            .frame(width: 65)
                            .foregroundStyle(Color(haircolor))
                    }
                }
            }
            .padding([.leading, .trailing])
            
            HStack {
                ForEach(hairColors2, id: \.self) { haircolor in
                    Button {
                        viewModel.hairColor = haircolor.replacingOccurrences(of: "Hair", with: "").lowercased()
                        
                        
                        
                    } label : {
                        Circle()
                            .frame(width: 65)
                            .foregroundStyle(Color(haircolor))
                    }
                }
                
                Spacer()
            }
            .padding([.leading, .trailing])
            
            HStack {
                Text("Short Styles")
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }.padding(.leading)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(shortStyles, id: \.self) { style in
                        
                        Button {
                            
                            viewModel.hairFront = style
                            
                        } label: {
                            
                            ZStack {
                                Image(viewModel.skin)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                                
                                Image(viewModel.hairColor + style)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100, alignment: .top)
                                    .padding(.horizontal, -20)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            
            HStack {
                Text("Longer Styles")
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }.padding(.leading)
               
            
            HStack {
                Text("Front")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }.padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(frontStyles, id: \.self) { style in
                        
                        Button {
                            
                            viewModel.hairFront = style
                            
                            if viewModel.hairBack == "" {
                                viewModel.hairBack = "back1"
                            }
                            
                        } label: {
                            
                            ZStack {
                                
                                if viewModel.hairBack != "" && viewModel.hairBack != "back6" {
                                    Image(viewModel.hairColor + viewModel.hairBack)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 100, alignment: .top)
                                    .padding(.horizontal, -20)
                                } else {
                                    Image(viewModel.hairColor + "back1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 100, alignment: .top)
                                        .padding(.horizontal, -20)
                                }
                                Image(viewModel.skin)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100, alignment: .top)
                                    .padding(.horizontal, -20)
                                
                                Image(viewModel.hairColor + style)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100, alignment: .top)
                                    .padding(.horizontal, -20)
                                
                            }
                        }
                    }
                    
                    Button {
                        viewModel.hairBack = "back6"
                        viewModel.hairFront = "front6"
                    } label: {
                        ZStack {
                            
                            Image(viewModel.hairColor + "back6")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                            
                            Image(viewModel.skin)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                            
                            Image(viewModel.hairColor + "front6")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                        }
                    }
                }
            }
            
            HStack {
                Text("Back")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }.padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(backStyles, id: \.self) { style in
                        
                        Button {
                            
                            viewModel.hairBack = style
                            
                            if viewModel.hairFront == "" || viewModel.hairFront.contains("short") || viewModel.hairFront == "front6" {
                                viewModel.hairFront = "front1"
                            }
                            
                        } label: {
                            
                            ZStack {
                                
                                Image(viewModel.hairColor + style)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100, alignment: .top)
                                    .padding(.horizontal, -20)
                                
                                Image(viewModel.skin)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100, alignment: .top)
                                    .padding(.horizontal, -20)
                                
                                if !viewModel.hairFront.contains("short") && viewModel.hairFront != "" && viewModel.hairFront != "front6" {
                                    Image(viewModel.hairColor + viewModel.hairFront)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 100, alignment: .top)
                                        .padding(.horizontal, -20)
                                } else {
                                    Image(viewModel.hairColor + "front1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 100, alignment: .top)
                                        .padding(.horizontal, -20)
                                }
                            }
                        }
                    }
                    
                    Button {
                        viewModel.hairBack = "back6"
                        viewModel.hairFront = "front6"
                    } label: {
                        ZStack {
                            
                            Image(viewModel.hairColor + "back6")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                            
                            Image(viewModel.skin)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                            
                            Image(viewModel.hairColor + "front6")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 100, alignment: .top)
                                .padding(.horizontal, -20)
                        }
                    }

                }
            }
            
        }
    }
}

#Preview {
    HairSelection()
}
