//
//  LoginView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = LoginViewViewModel()
    @State private var isSecure: Bool = true
    @State private var opacity: Double = 0
    
    var body: some View {
        ScrollView {
            
            VStack {
                   Spacer()
                   
                   Text(LocalizedStringKey("Welcome Back!"))
                       .font(.custom("Nunito", size: 40))
                       .scaledToFill()
                       .fontWeight(.black)
                       .foregroundStyle(Color(.mainBlue))
                       .padding(.top)
                       .multilineTextAlignment(.center)
                       
                   Spacer()
                   
                   VStack (spacing: 0){
                       Image(.firstScreenLogo)
                           .resizable()
                           .scaledToFit()
                           .frame(height: 220)
                   }
                   
                   Spacer()
                   
                
                if !viewModel.errorMessage.isEmpty {
                    Text(LocalizedStringKey(viewModel.errorMessage))
                        .foregroundColor(Color.red)
                }
                TextField("", text: $viewModel.username, prompt: Text(LocalizedStringKey("Username"))
                    .foregroundStyle(Color(UIColor.darkGray)))
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.custom("Nunito", size: 18))
                    .frame(width: 300)
                
                Spacer()
                
                HStack {
                    ZStack {
                        if isSecure {
                            SecureField("", text: $viewModel.password, prompt: Text(LocalizedStringKey("Password"))
                                .foregroundStyle(Color(.darkGray))
                            )
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .font(.custom("Nunito", size: 18))
                        } else {
                            TextField("", text: $viewModel.password, prompt: Text(LocalizedStringKey("Password"))
                                .foregroundStyle(Color(.darkGray)))
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .font(.custom("Nunito", size: 18))
                        }
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                isSecure.toggle()
                            }) {
                                Image(systemName: isSecure ? "eye.slash" : "eye")
                                    .foregroundColor(Color(.darkGray))
                                    .alignmentGuide(.trailing) { d in d[.leading] }
                            }
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .padding(.trailing, 18)
                        }
                    }
                }
                .padding([.top, .bottom])
                .frame(width: 300)
                
                NavigationLink(destination: RegisterFirstView()) {
                    UMButton(title: "Log In", background: .mainBlue) {
                        viewModel.login()
                        print(LocalizedStringKey("Logged In"))
                    }
                    .foregroundStyle(Color(.white))
                    .fontWeight(.bold)
                    .font(.custom("Nunito", size: 18))
                }
                .frame(width: 300, height: 60)
                .padding(.top)
                
                Spacer()
                
               }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.4)) {
                        opacity = 1
                    }
                }
               .navigationBarBackButtonHidden(true)
               .toolbar {
                   ToolbarItem(placement: .topBarLeading) {
                   Button {
                       dismiss()
                   } label: {
                       Image(systemName: "chevron.left")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 18)
                   }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
