//
//  ColorExplanation.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/7/24.
//

import SwiftUI

struct ColorExplanation: View {
    
    @State var showSources = false
    @Binding var isPresented: Bool
    @State private var opacity: Double = 0
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        
        ScrollView {
            HStack {
                Text(LocalizedStringKey("Flood Status"))
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
                
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34)
                }
                .padding(.trailing)
            }
            
            HStack {
                
                Text(LocalizedStringKey("Flood Warning"))
                    .font(.custom("Nunito", size: 24))
                    .bold()
                
                Spacer()
                
                Circle()
                    .fill(.red)
                    .frame(width: 50)
                    .overlay(Circle().stroke(lineWidth: 4).fill(.mainBlue))
                    .padding(.trailing)
            }
            
            Text(LocalizedStringKey("A red circle stands for a flood warning. This means that flooding will happen or is happening in someone's area."))
                .font(.custom("Nunito", size: 18))
            
            HStack {
                
                Text(LocalizedStringKey("Flood Advisory or Watch"))
                    .font(.custom("Nunito", size: 24))
                    .bold()
                
                Spacer()
                
                Circle()
                    .fill(.accentYellow)
                    .frame(width: 50)
                    .overlay(Circle().stroke(lineWidth: 4).fill(.mainBlue))
                    .padding(.trailing)
            }
            
            Text(LocalizedStringKey("A yellow circle stands for a flood advisory or watch in someone's area. A flood advisory means that a little flooding (not life-threatening) may happen. A flood watch means that flooding is more likely than normal."))
                .font(.custom("Nunito", size: 18))
            
            HStack {
                
                Text(LocalizedStringKey("Everything good!"))
                    .font(.custom("Nunito", size: 24))
                    .bold()
                
                Spacer()
                
                Circle()
                    .fill(.accentGreen)
                    .frame(width: 50)
                    .overlay(Circle().stroke(lineWidth: 4).fill(.mainBlue))
                    .padding(.trailing)
            }
            
            HStack {
                Text(LocalizedStringKey("A green circle stands for no current flood warnings. This means that the National Weather Service has not given flood warnings for someone's location."))
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito", size: 18))
                
                Spacer()
            }
            
            HStack {
                
                Text(LocalizedStringKey("No Connection"))
                    .font(.custom("Nunito", size: 24))
                    .bold()
                
                Spacer()
                
                Circle()
                    .fill(.gray)
                    .frame(width: 50)
                    .overlay(Circle().stroke(lineWidth: 4).fill(.mainBlue))
                    .padding(.trailing)
            }
            
            HStack {
                Text(LocalizedStringKey("A gray circle means that Umbrella is trying to get the weather for a location."))
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito", size: 18))
                
                Spacer()
            }
            
            Button {
                showSources.toggle()
            } label: {
                Text(LocalizedStringKey("Sources"))
                    .font(.custom("Nunito", size: 18))
            }
            .padding()
            
            Spacer()
        
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                opacity = 1
            }
        }
        .padding()
        .sheet(isPresented: $showSources, content: {
            
            HStack {
                Text(LocalizedStringKey("Sources"))
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
                
                Button {
                    showSources.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34)
                }
            }
            .padding([.top, .horizontal])
            FloodSafetyResources()
                .padding(.leading)
        })
    }
}

#Preview {
    struct ColorExplanationViewContainer: View {
        @State private var isPresented = false
        
        var body: some View {
            ColorExplanation(isPresented: $isPresented)
        }
    }
    
    return ColorExplanationViewContainer()
}
