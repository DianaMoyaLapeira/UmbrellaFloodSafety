//
//  BreathingView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/14/24.
//

import SwiftUI

struct BreathingView: View {
    
    @StateObject var viewModel = BreathingViewModel()
    @State var gradientColors: Bool = true
    
    var body: some View {
        
        VStack {
            
            VStack {
                HStack {
                    Text("Breathing Exercises")
                        .font(.custom(("Nunito"), size: 32, relativeTo: .largeTitle))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Stay calm and stay safe")
                        .font(.custom("Nunito", size: 18, relativeTo: .body))
                    
                    Spacer()
                }
                .padding([.horizontal, .bottom])
            }
            .padding(.top)
            
            Spacer()
            
            BreathingAvatarView(viewModel: viewModel, profileString: "skin3,shirt2,gingerback2;gingerfront2,mouth5,blush3,")
                .mask(Circle())
                .frame(height: 450)
                .shadow(color: .white, radius: 10)
                .background(
                    Rectangle()
                        .foregroundStyle(EllipticalGradient(gradient: viewModel.gradientColors ? Gradient(colors: [.clear, .clear]) : Gradient(colors: [.mainBlue, .mainBlue, .clear])))
                )
                
            
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    gradientColors.toggle()
                }
                viewModel.breathCycle()
                viewModel.playing.toggle()
            } label: {
                
                if viewModel.playing {
                    ZStack {
                        Circle()
                            .foregroundStyle(.mainBlue)
                        
                        Image(systemName: "pause.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .padding(25)
                    }
                    .frame(height: 80)
                    .padding()
                } else {
                    ZStack(alignment: .trailing) {
                      
                        Circle()
                            .foregroundStyle(.mainBlue)
                            .padding(5)
                            .shadow(radius: 10)
                        
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .padding(25)
                    }
                    .frame(height: 90)
                    .padding()
                }
            }
            
            Spacer()
            
            Text(viewModel.stage)
                .font(.custom("Nunito", size: 18, relativeTo: .body))
                .bold()
                .padding(.bottom)
            
            Spacer()
        }
        .padding(.vertical, 15)
    }
}

#Preview {
    BreathingView()
}
