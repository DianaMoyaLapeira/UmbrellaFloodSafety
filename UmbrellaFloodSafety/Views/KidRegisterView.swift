//
//  RegisterAsKidView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI

struct KidRegisterView: View {
    
    @State private var nextpage: String? = nil
    @StateObject var viewModel = KidRegisterViewViewModel()
    @State private var isSecure: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Create Your \nAccount")
                    .font(.custom("Nunito", size: 40))
                    .scaledToFill()
                    .fontWeight(.black)
                    .foregroundStyle(Color(.mainBlue))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image(.children)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                Spacer()
                
                TextField("", text: $viewModel.name, prompt: Text("First Name")
                    .foregroundStyle(Color(.darkGray)))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.custom("Nunito", size: 18))
                    .frame(width: 300, height: 60)
                
                Spacer()
                
                TextField("", text: $viewModel.username, prompt: Text("Username")
                    .foregroundStyle(Color(.darkGray)))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.custom("Nunito", size: 18))
                    .frame(width: 300, height: 60)
                
                Spacer()
                
                HStack {
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
                
                Spacer()
                
                NavigationLink(destination: RegisterFirstView()) {
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
}

#Preview {
    KidRegisterView()
}
