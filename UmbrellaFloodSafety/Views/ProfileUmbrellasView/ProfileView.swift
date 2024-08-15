//
//  ProfileView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var manager = FirebaseManager.shared
    @State private var isSheetPresented = false
    @StateObject var viewModel: ProfileViewViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showConfigurationSheet: Bool = false
    
    init(username: String) {
        self._viewModel = StateObject(wrappedValue: ProfileViewViewModel(username: username))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        
        
        NavigationStack {
                
                HStack {
                    Text("Profile")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(Color(.mainBlue))
                    
                    Spacer()
                    
                    Button {
                        showConfigurationSheet.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.mainBlue)
                    }
                    
                }
                .padding()
                
                Divider()
                
                HStack {
                    VStack {
                        HStack {
                            Text("\(manager.currentUserUsername)")
                                .font(.custom("Nunito", size: 24))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            
                            Spacer()
                        }
                        HStack {
                            Text("\(manager.currentUserName)")
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
                        
                        if manager.currentUserAvatar != "" {
                            ProfilePictureView(profileString: manager.currentUserAvatar)
                                .clipShape(Circle())
                                .frame(width: 120, height: 130, alignment: .bottom)
                                .background(Circle().fill(.mainBlue).opacity(0.1))
                        }
                       
                        Circle()
                            .stroke(lineWidth: 6)
                            .frame(width: 130)
                            .foregroundStyle(Color.mainBlue)
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
                        
                        if manager.userGroups.count != 0 {
                            VStack() {
                                ForEach(manager.userGroups.keys.sorted(), id: \.self) { groupId in
                                    NavigationLink(destination: UmbrellaView(groupId: groupId)) {
                                        UmbrellaListView(groupId: groupId)
                                    }
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 6).foregroundStyle(Color.mainBlue))
                                .padding()
                        } else {
                            VStack {
                                Image(.mapEmptyState)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 350, height: 100)
                                    .padding(.top)
                                
                                Text("No Umbrellas Yet")
                                    .foregroundStyle(.mainBlue)
                                    .font(.custom("Nunito", size: 18))
                                    .bold()
                                    .padding(.bottom)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 6).foregroundStyle(Color.mainBlue))
                                .padding()
                        }
                           
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color(.mainBlue))
                            NavigationLink("Join an Umbrella", destination: JoinAnUmbrella(username: viewModel.username))
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
            .sheet(isPresented: $showConfigurationSheet, content: {
                Settings(isPresented: $showConfigurationSheet)
            })
            .sheet(isPresented: $isSheetPresented, content: {
                EditProfileView(isPresented: $isSheetPresented, username: viewModel.username)
                    })
            
        }
    }

#Preview {
    ProfileView(username: "Testadult")
}
