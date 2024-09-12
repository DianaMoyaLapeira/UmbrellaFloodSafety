//
//  UserListView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 1/7/24.
//

import SwiftUI
import CoreLocation

struct UserListView: View {
  
    var groupMember: String = ""
    @ObservedObject var viewModel: UserListViewViewModel
    init(groupId: String, groupMember: String) {
        self.groupMember = groupMember
        self._viewModel = ObservedObject(wrappedValue: UserListViewViewModel(groupId: groupId, username: groupMember))
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                if FirebaseManager.shared.groupMembersAvatars[groupMember] != "" || FirebaseManager.shared.groupMembersAvatars[groupMember] != nil {
                    MapMarker(profileString: FirebaseManager.shared.groupMembersAvatars[groupMember] ?? "", username: groupMember, frameWidth: 25, circleWidth: 80, lineWidth: 4, paddingPic: 8, riskColor: .secondary)
                        .frame(width: 80, height: 80)
                    .padding([.leading, .trailing])
                } else {
                    // backup blank character
                    MapMarker(profileString: "skin11,shirt1,black,mouth1,,", username: groupMember, frameWidth: 25, circleWidth: 80, lineWidth: 4, paddingPic: 8, riskColor: .secondary)
                        .frame(width: 80, height: 80)
                    .padding([.leading, .trailing])
                }
                
                VStack {
                    HStack {
                        
                        Text("\(viewModel.name)")
                            .font(.custom("Nunito", size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        
                        Spacer()
                    
                    }
                    
                    HStack {
                        Text("Near \(viewModel.address)")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                            .font(.custom("Nunito", size: 18))
                        
                        Spacer()
                    }
                }
            }
            
            Divider()
        }

    }
    
}

#Preview {
    UserListView(groupId: "588217", groupMember: "testadult")
}
