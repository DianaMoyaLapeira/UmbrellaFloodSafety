//
//  CreateAvatar.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 11/7/24.
//

import SwiftUI

struct CreateAvatar: View {
    
    @ObservedObject var viewModel = CreateAvatarViewViewModel.shared
    @State var selection = 0
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Create an Avatar")
                    .font(.custom("Nunito", size: 32))
                    .fontWeight(.black)
                    .foregroundStyle(Color.mainBlue)
                
                Spacer()
                
                Button {
                    viewModel.uploadAvatarIntoDB()
                    
                    isPresented.toggle()
                } label: {
                    Text("Done")
                        .font(.custom("Nunito", size: 18))
                        .fontWeight(.black)
                        .foregroundStyle(Color.mainBlue)
                }
            }
            .padding([.leading, .trailing])
            
            ProfilePictureView(profileString: viewModel.avatarString)
                .frame(width: 400, height: 300)
                .background(Rectangle().foregroundStyle(.mainBlue).opacity(0.1))
                
            
            HStack {
                
                
                Button {
                    selection = 0
                } label: {
                    if selection == 0 {
                        VStack {
                            Text("Skin")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.black)
                        }
                    
                    } else {
                        Text("Skin")
                            .font(.custom("Nunito", size: 24))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                    }
                    
                }
                Spacer()
                
                Button {
                    selection = 1
                } label: {
                    if selection == 1 {
                        VStack {
                            Text("Hair")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.black)
                        }
                    
                    } else {
                        Text("Hair")
                            .font(.custom("Nunito", size: 24))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Button {
                    selection = 2
                } label: {
                    if selection == 2 {
                        VStack {
                            Text("Shirt")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.black)
                        }
                    
                    } else {
                        Text("Shirt")
                            .font(.custom("Nunito", size: 24))
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                
                Spacer()
                
                Button {
                    selection = 3
                } label: {
                    if selection == 3 {
                        VStack {
                            Text("Accessories")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.black)
                        }
                    
                    } else {
                        Text("Accessories")
                            .font(.custom("Nunito", size: 24))
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                
                
            }
            .padding([.leading, .trailing])
            
            if selection == 0 {
                SkinAvatarSelection()
            } else if selection == 1{
                HairSelection()
            } else if selection == 2 {
                ShirtSelection()
            } else if selection == 3 {
                AccessoriesSelection()
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
                Image(.fullProgress)
            }
        }
    }
}



#Preview {
    struct CreateAvatarViewContainer: View {
        @State private var isPresented = false
        
        var body: some View {
            CreateAvatar(isPresented: $isPresented)
        }
    }
    
    return CreateAvatarViewContainer()
}
