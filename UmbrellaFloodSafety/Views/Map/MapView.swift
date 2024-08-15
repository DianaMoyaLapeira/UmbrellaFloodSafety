//
//  MapView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//
import FirebaseFirestore
import SwiftUI
import MapKit

struct memberLocationMap: Identifiable, Hashable {
    static func == (lhs: memberLocationMap, rhs: memberLocationMap) -> Bool {
        return (lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude)
    }
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MapView: View {
    
    @Binding var cameraPosition: MapCameraPosition
    @State private var showSheet: Bool = true
    @ObservedObject var viewModel = MapViewViewModel.shared
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @State private var selection = "Red"
    var locationArray: [memberLocationMap] {
        var array = [memberLocationMap]()
        for member in firebaseManager.groupMembers[viewModel.selection] ?? [] {
            array.append(memberLocationMap(coordinate: firebaseManager.groupMembersLocations[member] ?? CLLocationCoordinate2D()))
        }
        return array
    }
    
    @State var showNotificationSheet: Bool = false
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                
                Spacer()
                HStack {
                    Text("Hello \(firebaseManager.currentUserName)!")
                        .fontWeight(.black)
                        .font(.custom("Nunito", size: 34))
                        .foregroundStyle(Color(.mainBlue))
                    Spacer()
                    
                    Button {
                        showNotificationSheet.toggle()
                    } label: {
                        Image(systemName: "bell")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.mainBlue)
                    }
                }
                .padding()
                
                
                ZStack(alignment: .topLeading)
                {
                    Map(position: $cameraPosition) {
                        
                        ForEach(firebaseManager.groupMembers[viewModel.selection] ?? [], id: \.self) { member in
                            
                            if firebaseManager.groupMembersAvatars[member] != "" || firebaseManager.groupMembers[member] != nil {
                                
                                let coordinate = firebaseManager.groupMembersLocations[member] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                                
                                Annotation("", coordinate: coordinate) {
                                    
                                    Button {
                                        withAnimation {
                                            cameraPosition = .item(MKMapItem(placemark: .init(coordinate: coordinate)))
                                        }
                                    } label: {
                                        MapMarker(profileString: firebaseManager.groupMembersAvatars[member] ?? "", username: member, frameWidth: 30, circleWidth: 100, lineWidth: 5, paddingPic: 5)
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        
                        Call911Button()
                            .padding()
                        
                        Spacer()
                        
                        if viewModel.selection != "No Umbrellas yet" {
                            Picker(LocalizedStringKey("Select an Umbrella"), selection: $viewModel.selection) {
                                ForEach(firebaseManager.userGroups.keys.sorted(), id: \.self) { groupId in
                                    if let groupName = firebaseManager.userGroups[groupId] {
                                        Text("\(groupName)").tag(groupId as String?)
                                            .font(.custom("Nunito", size: 18))
                                    }
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.white))
                            .pickerStyle(.menu)
                            .padding()
                        }
                    }
                }
            }
            .onAppear(perform: {
                NotificationViewViewModel.shared.getRiskNotifications()
            })
            .onChange(of: firebaseManager.groupMembersLocations, {
                NotificationViewViewModel.shared.getRiskNotifications()
            })
            .sheet(isPresented: $showNotificationSheet, content: {
                NotificationView(isPresented: $showNotificationSheet)
                    .frame(width: 400)
                
            })
            .presentationDragIndicator(.visible)
        }
    }
}



#Preview {
    struct MapViewViewContainer: View {
        @State private var cameraPosition: MapCameraPosition = .automatic
        
        var body: some View {
            MapView(cameraPosition: $cameraPosition)
        }
    }
    
    return MapViewViewContainer()
}


