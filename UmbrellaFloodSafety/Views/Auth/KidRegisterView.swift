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
    @State var presentAvatar = true
    
    // PresentAvatar does nothing in this context, it is just a placeholder for future use
    
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer()
                
                VStack(spacing: -60) {
                    Text("Create Your \nAccount")
                        .font(.custom("Nunito", size: 40))
                        .scaledToFill()
                        .fontWeight(.black)
                        .foregroundStyle(Color(.mainBlue))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    
                    
                    Image(.children)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                
                
                TextField("", text: $viewModel.name, prompt: Text("First Name")
                    .foregroundStyle(Color(.darkGray)))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.custom("Nunito", size: 18))
                    .frame(width: 300)
                
                Spacer()
                
                TextField("", text: $viewModel.username, prompt: Text("Username")
                    .foregroundStyle(Color(.darkGray)))
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
                
                Spacer()
                
                NavigationLink(destination: CreateAvatar(isPresented: $presentAvatar)
                    .onAppear {
                        viewModel.register()
                    }
                
                ) {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(.mainBlue)
                        
                        Text("Create account")
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 300, height: 60)
                }
                
                Spacer()
            }
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
