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
    @State var showAlert = false
    @State var showCircleExplanation: Bool = false

    init() {
    }

    var body: some View {
        ScrollView {
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
                    
                    HStack {
                        Call911Button()
                        
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Image(.mapEmptyState)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Text("No Umbrellas yet.\n Try adding some in the profile tab!")
                        .multilineTextAlignment(.center)
                        .font(.custom("Nunito", size: 18))
                        .padding(.horizontal)
                        .bold()
                }
                
                Spacer()
                    
                Button {
                    showCircleExplanation.toggle()
                } label: {
                    Text("What do the green, yellow, or red circles mean?")
                        .font(.custom("Nunito", size: 18))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .foregroundStyle(.secondary)
                
            }
        }
        .sheet(isPresented: $showCircleExplanation, content: {
            ColorExplanation(isPresented: $showCircleExplanation)
        })
        
    }
    
}

#Preview {
    MapViewSheet()
}
