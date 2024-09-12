//
//  StartView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI

struct StartView: View {
    @State private var path = NavigationPath()
    @State private var opacity: Double = 0
    
    var body: some View {
        NavigationView {
            NavigationStack {
                VStack {
                    Spacer()
                    Image(.firstScreenLogo)
                        .resizable()
                        .frame(width: 300, height: 300)
                    Text("Umbrella")
                        .fontWeight(.black)
                        .foregroundStyle(Color(.mainBlue))
                        .font(.custom("Nunito", size: 48))
                    Text(LocalizedStringKey("Your flood safety companion"))
                        .fontWeight(.medium)
                        .foregroundStyle(Color(.mainBlue))
                        .font(.custom("Nunito", size: 22))
                        .multilineTextAlignment(.center)
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(Color(.mainBlue))
                        NavigationLink(LocalizedStringKey("Get Started"), destination: RegisterFirstView().transition(.blurReplace))
                            .foregroundStyle(Color(.white))
                            .fontWeight(.bold)
                            .font(.custom("Nunito", size: 18))
                    }
                    .frame(width: 300, height: 60)
                    .padding(.bottom)
                    .padding(.top)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(.mainBlue), lineWidth: 4)
                        NavigationLink(LocalizedStringKey("I Already Have an Account"), destination: LoginView())
                            .foregroundStyle(Color(.mainBlue))
                            .fontWeight(.bold)
                            .font(.custom("Nunito", size: 18))
                    }
                    .frame(width: 300, height: 60)
                    Spacer()
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.4)) {
                        opacity = 1
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    StartView()
}
