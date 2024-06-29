//
//  ProfileView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isSheetPresented = false
    @State var viewModel: ProfileViewViewModel
    private let listData = ["One", "Two", "Three", "Four", "Five"]
    @Environment(\.presentationMode) var presentationMode
    
    init(username: String) {
        self._viewModel = State(wrappedValue: ProfileViewViewModel(username: username))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "bell")
                }
                .padding(.trailing)
                
                HStack {
                    Text("Profile")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(Color(.mainBlue))
                    Spacer()
                }
                .padding()
                
                Divider()
                
                HStack {
                    VStack {
                        HStack {
                            Text("Hello")
                                .font(.custom("Nunito", size: 24))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            
                            Spacer()
                        }
                        HStack {
                            Text("Hello")
                                .font(.custom("Nunito", size: 18))
                            .foregroundStyle(Color(.darkGray))
                            
                            Spacer()
                        }
                        
                        HStack {
                            UMButton(title: "Edit Profile", background: .mainBlue) {
                                isSheetPresented.toggle()
                            }
                            .frame(width: 150, height: 40)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .frame(width: 130)
                            .foregroundStyle(Color.mainBlue)
                        Circle()
                            .frame(width: 120)
                            .foregroundStyle(Color.white)
                        Image(.adultWoman)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("MyUmbrellas")
                        .font(.custom("Nunito", size: 34))
                        .foregroundStyle(Color(.mainBlue))
                        .fontWeight(.black)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer()
                    
                
                    ScrollView {
                        
                        ZStack {
                            List {
                                VStack() {
                                    UmbrellaListView()
                                    UmbrellaListView()
                                }
                                
                            }.scrollContentBackground(.hidden)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .padding([.top, .bottom])
                            
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.mainBlue, lineWidth: 4)
                                .padding()
                        }
                        .frame(height: 200)
                        
    
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color(.mainBlue))
                            NavigationLink("Join an Umbrella", destination: NewUmbrellaView(username: viewModel.username))
                                .foregroundStyle(Color(.white))
                                .fontWeight(.bold)
                                .font(.custom("Nunito", size: 18))
                        }
                        .frame(height: 70)
                        .padding()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color(.mainBlue))
                            NavigationLink("Create an Umbrella", destination: NewUmbrellaView(username: viewModel.username))
                                .foregroundStyle(Color(.white))
                                .fontWeight(.bold)
                                .font(.custom("Nunito", size: 18))
                        }
                        .frame(height: 70)
                        .padding()
                        
                        UMButtonStoke(title: "Log Out", background: .mainBlue) {
                            viewModel.signOut()
                        }
                        .frame(height: 70)
                        .padding()
                        
                }
                    
                Spacer()
            }
            .sheet(isPresented: $isSheetPresented, content: {
                EditProfileView(isPresented: $isSheetPresented, username: viewModel.username)
                    })
        }
    }
}

#Preview {
    ProfileView(username: "Testadult")
}
