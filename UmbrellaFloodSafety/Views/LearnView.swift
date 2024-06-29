//
//  LearnView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct LearnView: View {
    @StateObject var viewModel: LearnViewViewModel
    
    init(username: String) {
        self._viewModel = StateObject(wrappedValue: LearnViewViewModel(username: username))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Learn")
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(Color.mainBlue)
                    .fontWeight(.black)
                    .padding()
                
                Spacer()
            }
            
            Divider()
            
            ScrollView {
                Section() {
                    
                    
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(height: 150)
                        .padding(.leading)
                        .padding(.trailing)
                        .foregroundStyle(Color.accentGreen)
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(height: 150)
                        .padding()
                        .foregroundStyle(Color.accentYellow)
                    
                    Divider()
                } header: {
                    HStack {
                        Text("Emergencies")
                            .font(.custom("Nunito", size: 24))
                            .foregroundStyle(Color.red)
                            .fontWeight(.black)
                            .padding()
                        
                        Spacer()
                    }
                }
                
                Section() {
                    
                    
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(height: 150)
                        .padding(.leading)
                        .padding(.trailing)
                        .foregroundStyle(Color.skyBlue)
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(height: 150)
                        .padding()
                        .foregroundStyle(Color.orange)
                    
                    Divider()
                } header: {
                    HStack {
                        Text("Prepare")
                            .font(.custom("Nunito", size: 24))
                            .foregroundStyle(Color.mainBlue)
                            .fontWeight(.black)
                            .padding()
                        
                        Spacer()
                    }
                }
                
            }
            
            Spacer()
        }
    }
}

#Preview {
    LearnView(username: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
