//
//  MapViewSheet.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import CoreLocation
import SwiftUI
import MapKit

struct MapViewSheet: View {
    
    @Binding var cameraPosition: MapCameraPosition
    @StateObject var firebaseManager = FirebaseManager.shared
    @StateObject var mapViewViewModel = MapViewViewModel.shared
    @State var showAlert = false
    @State var showCircleExplanation: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                
                if mapViewViewModel.selection != "No Umbrellas yet" {
                    
                    HStack {
                        Text("\(firebaseManager.userGroups[mapViewViewModel.selection] ?? "Umbrella")")
                            .multilineTextAlignment(.leading)
                            .font(.custom("Nunito", size: 34))
                            .fontWeight(.black)
                            .foregroundStyle(Color.mainBlue)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    ForEach(firebaseManager.groupMembers[mapViewViewModel.selection] ?? [], id: \.self) { member in
                        
                        Button {
                            withAnimation {
                                cameraPosition = .item(MKMapItem(placemark: .init(coordinate: firebaseManager.groupMembersLocations[member] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))))
                            }
                        } label: {
                            UserListView(groupId: mapViewViewModel.selection, groupMember: member)
                        }
                        .buttonStyle(.plain)
            
                    }
                } else {
                    
                    Image(.mapEmptyState)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                    
                    Text(LocalizedStringKey("No Umbrellas yet.\nTry adding some in the profile tab!"))
                        .multilineTextAlignment(.center)
                        .font(.custom("Nunito", size: 18))
                        .padding(.horizontal)
                        .bold()
                }
                
                Spacer()
                    
                Button {
                    showCircleExplanation.toggle()
                } label: {
                    Text(LocalizedStringKey("What do the green, yellow, red, or gray circles mean?"))
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
    struct mapViewSheetContainer: View {
        @State private var cameraPosition: MapCameraPosition = .automatic
        
        var body: some View {
            MapViewSheet(cameraPosition: $cameraPosition)
        }
    }
    
    return mapViewSheetContainer()
}
