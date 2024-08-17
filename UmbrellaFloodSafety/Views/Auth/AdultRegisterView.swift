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
    @State var isAvatarPresented = true
    @State var opacity: Double = 0
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text(LocalizedStringKey("Create Your \nAccount"))
                    .font(.custom("Nunito", size: 40))
                    .scaledToFill()
                    .fontWeight(.black)
                    .foregroundStyle(Color(.mainBlue))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                
                Spacer()
                Image(.briefcase)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                
                
                NavigationStack {
                    
                    Spacer()
                    
                    TextField("", text: $viewModel.name, prompt: Text(LocalizedStringKey("First Name"))
                        .foregroundStyle(Color(.darkGray)))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.custom("Nunito", size: 18))
                    .frame(width: 300)
                    .padding(.bottom)
                    
                    TextField("", text: $viewModel.username, prompt: Text(LocalizedStringKey("Username"))
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
                    .padding(.bottom)
                    .frame(width: 300)
                    
                    NavigationLink(destination: CreateAvatar(isPresented: $isAvatarPresented)
                        .onAppear {
                            viewModel.register()
                        }
                                   
                    ) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(.mainBlue)
                            
                            Text(LocalizedStringKey("Create Account"))
                                .font(.custom("Nunito", size: 18))
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .frame(width: 300, height: 60)
                    }
                    
                    Spacer()
                }
            }
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
                        .frame(width: 19)
                }
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
