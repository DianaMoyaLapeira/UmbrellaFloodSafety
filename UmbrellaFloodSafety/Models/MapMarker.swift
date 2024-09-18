//
//  MapMarker.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/7/24.
//

import SwiftUI
import CoreLocation

struct MapMarker: View {
    
    var profileString: String
    @StateObject var firebaseManager = FirebaseManager.shared
    var weatherManager = WeatherManager()
    var username: String
    var frameWidth: CGFloat
    var circleWidth: CGFloat
    var lineWidth: CGFloat
    var paddingPic: CGFloat
    @State var riskColor: Color = .gray
    
    var body: some View {
        
        ZStack() {
            
            Circle()
                .foregroundStyle(.mainBlue.opacity(0.1))
            
            ProfilePictureView(profileString: profileString)
                .clipShape(Circle())
                .padding(.top, paddingPic)
                .frame(alignment: .bottom)
                
            
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundStyle(Color.mainBlue)
            
            HStack() {
                Spacer()
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: frameWidth)
                        .foregroundStyle(riskColor)
                        .opacity(1)
                        .overlay(Circle().stroke(lineWidth: lineWidth).foregroundStyle(Color.mainBlue))
                        .padding([.top, .leading])
                        .onAppear {
                            Task {
                                riskColor = await getRiskColor()
                            }
                        }
                        .onChange(of: firebaseManager.groupMembersLocations[username]) {
                            Task {
                                riskColor = await getRiskColor()
                            }
                        }
                }
            }.frame(width: circleWidth)
        }.frame(height: circleWidth)
    }
    
    func getRiskColor() async -> Color {
        var riskLevel: Int = 0

        riskLevel = await weatherManager.getRiskLevel(coordinate: firebaseManager.groupMembersLocations[username] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
        
        switch riskLevel {
        case 0: return .accentGreen
        case 1: return .accentYellow
        case 2: return .red
        default:
            return .gray
        }

    }
}



#Preview {
    MapMarker(profileString: "skin3,shirt8,lightbrownback1;lightbrownfront1,mouth5,blush3,"
              , username: "testadult", frameWidth: 100, circleWidth: 400, lineWidth: 8, paddingPic: 20)
}
