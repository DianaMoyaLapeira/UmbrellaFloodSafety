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
    
    var body: some View {
        ScrollView {
            VStack {
                   Spacer()
                   
                   Text("Welcome Back!")
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
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                TextField("Username", text: $viewModel.username, prompt: Text("Username"))
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .foregroundStyle(Color(.darkGray))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.custom("Nunito", size: 18))
                    .frame(width: 300, height: 60)
                
                Spacer()
                
                HStack {
                    if isSecure {
                        SecureField("Password", text: $viewModel.password, prompt: Text("Password")
                            .foregroundStyle(Color(.darkGray))
                        )
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .font(.custom("Nunito", size: 18))
                    } else {
                        TextField("Password", text: $viewModel.password, prompt: Text("Password")
                            .foregroundStyle(Color(.darkGray)))
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .font(.custom("Nunito", size: 18))
                    }
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(Color(.darkGray))
                    }
                    .padding(.trailing, 1)
                }
                .padding(.top)
                .padding(.bottom)
                .frame(width: 300, height: 60)
                
                NavigationLink(destination: RegisterFirstView()) {
                    UMButton(title: "Log In", background: .mainBlue) {
                        viewModel.login()
                    }
                    .foregroundStyle(Color(.white))
                    .fontWeight(.bold)
                    .font(.custom("Nunito", size: 18))
                }
                .frame(width: 300, height: 60)
                .padding(.top)
                
                      
               }
               .navigationTitle("Detail View")
               .navigationBarBackButtonHidden(true)
               .toolbar {
                   ToolbarItem(placement: .topBarLeading) {
                       Button(action: {
                           dismiss()
                       }) {
                           Label {
                                Text("Back")
                           } icon: {
                               Image(.backArrow)
                                           }
                       }
                       .padding()
                   }
           }
        }
       }
}

#Preview {
    LoginView()
}
