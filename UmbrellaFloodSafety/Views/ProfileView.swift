//
//  ProfileView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewViewModel
    private let listData = ["One", "Two", "Three", "Four", "Five"]
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: ProfileViewViewModel(userId: userId))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
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
                        Text("Diana Moya")
                            .font(.custom("Nunito", size: 24))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }
                    HStack {
                        Text("dianamoya08")
                            .font(.custom("Nunito", size: 18))
                        .foregroundStyle(Color(.darkGray))
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Image(.adultWoman)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
            }
            .padding()
            
            Divider()
            
            HStack {
                Text("MyUmbrellas")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(Color(.mainBlue))
                    .fontWeight(.black)
                    .padding(.leading)
                
                Spacer()
            }
            
            Spacer()
            
            UMButton(title: "Join An Umbrella", background: .mainBlue) {
                //
            }
            
            UMButton(title: "Create An Umbrella", background: .mainBlue) {
                //
            }
            
            Spacer()
            
            UMButtonStoke(title: "Log Out", background: .mainBlue) {
                //
            }
        }
    }
}

#Preview {
    ProfileView(userId: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
