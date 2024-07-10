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
    
    @State private var showSheet: Bool = true
    @StateObject var viewModel = MapViewViewModel.shared
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @State private var selection = "Red"
    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
    var locationArray: [memberLocationMap] {
        var array = [memberLocationMap]()
        for member in firebaseManager.groupMembers[viewModel.selection] ?? [] {
            array.append(memberLocationMap(coordinate: firebaseManager.groupMembersLocations[member] ?? CLLocationCoordinate2D()))
        }
        return array
    }
    @State var showNotificationSheet: Bool = false
    
    init(username: String) {
        
    }
    
    var body: some View {
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
                        .frame(width: 34, height: 34)
                        .foregroundStyle(Color.mainBlue)
                }
            }
            .padding()
            
            
            ZStack(alignment: .topLeading) {
                Map() {
                    
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: 9.940158, longitude: -84.144093), anchor: .bottom) {

                                MapMarker(image: Image(.children), username: "testadult", frameWidth: 30, circleWidth: 100, lineWidth: 5)
                                    
                    }
                }
                if viewModel.selection != "No Umbrellas yet" {
                    Picker("Select an Umbrella", selection: $viewModel.selection) {
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
}



#Preview {
    MapView(username: "testadult")
}
