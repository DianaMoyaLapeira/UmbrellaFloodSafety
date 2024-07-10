//
//  UserListView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 1/7/24.
//

import SwiftUI
import CoreLocation

struct UserListView: View {
    
    let image: Image
    var groupMember: String = ""
    @ObservedObject var viewModel: UserListViewViewModel
    init(groupId: String, image: Image, groupMember: String) {
        self.image = image
        self.groupMember = groupMember
        self._viewModel = ObservedObject(wrappedValue: UserListViewViewModel(groupId: groupId, username: groupMember))
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                MapMarker(image: image, username: groupMember, frameWidth: 25, circleWidth: 80, lineWidth: 4)
                    .frame(width: 80, height: 80)
                    .padding([.leading, .trailing])
                    
                
                VStack {
                    HStack {
                        
                        Text("\(viewModel.name)")
                            .font(.custom("Nunito", size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.mainBlue)
                        
                        Spacer()
                    
                    }
                    
                    HStack {
                        Text("\(viewModel.address)")
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
    UserListView(groupId: "588217", image: Image(.children), groupMember: "testadult")
}
