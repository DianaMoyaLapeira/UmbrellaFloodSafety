//
//  AdultRegisterView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI

struct AdultRegisterView: View {
    
    @StateObject var viewModel = AdultRegisterViewViewModel()
    @State private var isSecure: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            Text("Create Your \nAccount")
                .font(.custom("Nunito", size: 40))
                .scaledToFill()
                .fontWeight(.black)
                .foregroundStyle(Color(.mainBlue))
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Spacer()
            Image(.umbrellaLogo)
                .resizable()
                .scaledToFit()
                .frame(height: 220)
            
            
            NavigationStack {
                
                Spacer()
                
                Text("Thank you for choosing Umbrella!")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.mainBlue)
                
                Spacer()
                
                TextField("", text: $viewModel.name, prompt: Text("First Name")
                    .foregroundStyle(Color(.darkGray)))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
                .font(.custom("Nunito", size: 18))
                .frame(width: 300)
                .padding(.bottom)
                
                TextField("", text: $viewModel.username, prompt: Text("Username")
                    .foregroundStyle(Color(.darkGray)))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
                .font(.custom("Nunito", size: 18))
                .frame(width: 300)
                .padding(.bottom)
                
                HStack {
                    ZStack {
                        if isSecure {
                            SecureField("", text: $viewModel.password, prompt: Text("Password")
                                .foregroundStyle(Color(.darkGray))
                            )
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .font(.custom("Nunito", size: 18))
                        } else {
                            TextField("", text: $viewModel.password, prompt: Text("Password")
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
                .padding(.bottom)
                .frame(width: 300)
                
                
                NavigationLink(destination: MainView()) {
                    UMButton(title: "Create Account", background: .mainBlue) {
                        viewModel.register()
                    }
                    .foregroundStyle(Color(.white))
                    .fontWeight(.bold)
                    .font(.custom("Nunito", size: 18))
                }
                .frame(width: 300, height: 60)
                .padding(.top)
                
                Spacer()
            }
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
            ToolbarItemGroup(placement: .principal) {
                Image(.twoThirdsProgress)
            }
        }
    }
}

#Preview {
    AdultRegisterView()
}
