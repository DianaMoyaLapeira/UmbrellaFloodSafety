//
//  MapViewSheet.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import CoreLocation
import SwiftUI

struct MapViewSheet: View {
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @StateObject var mapViewViewModel = MapViewViewModel.shared

    init() {
    }

    var body: some View {
        VStack {
            
            if mapViewViewModel.selection != "No Umbrellas yet" {
                
                HStack {
                    Text("\(firebaseManager.userGroups[mapViewViewModel.selection] ?? "MyUmbrella")")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                    .foregroundStyle(Color.mainBlue)
                    .padding(.leading)
                    
                    Spacer()
                }
                ForEach(firebaseManager.groupMembers[mapViewViewModel.selection] ?? [], id: \.self) { member in
                    UserListView(groupId: mapViewViewModel.selection, image: Image(.children), groupMember: member)
                }
            } else {
                Text("No Umbrellas yet. Try adding some in the profile tab!")
            }
            
            Text("\(mapViewViewModel.selection)")
            
            Button {
                print("\(mapViewViewModel.selection) Button")
            } label: {
                Text("Click me")
            }
        }
        
    }
    
}

#Preview {
    MapViewSheet()
}
