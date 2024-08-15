//
//  UnblockUsers.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 23/7/24.
//

import SwiftUI

struct UnblockUsers: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var opacity: Double = 0
    var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Blocked Users")
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            
            if FirebaseManager.shared.blockedUsers.count > 0 {
                ForEach(FirebaseManager.shared.blockedUsers, id: \.self) { user in
                    VStack {
                        HStack {
                            Text(user)
                                .font(.custom("Nunito", size: 18))
                                .bold()
                            
                            Spacer()
                            
                            UMButton(title: "Unblock", background: .mainBlue) {
                                viewModel.unblockUser(user: user)
                            }
                            .frame(width: 100, height: 40)
                        }
                        
                        Divider()
                    }
                }
            } else {
                
                Image(.mapEmptyState)
                Text("You have no blocked users")
                    .font(.custom("Nunito", size: 18))
                    .bold()
            }
            
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
        .padding()
    }
}

#Preview {
    UnblockUsers()
}
