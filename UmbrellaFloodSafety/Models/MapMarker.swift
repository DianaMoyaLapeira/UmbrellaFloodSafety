//
//  MapMarker.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/7/24.
//

import SwiftUI
import CoreLocation

struct MapMarker: View {
    
    var image: Image
    var username: String
    var frameWidth: CGFloat
    var circleWidth: CGFloat
    var lineWidth: CGFloat
    @State var riskLevel: Int = 3
    @State var riskColor: Color = .gray
    var body: some View {
        
        ZStack() {
            image
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                
            
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
                        .overlay(Circle().stroke(lineWidth: lineWidth).foregroundStyle(Color.mainBlue))
                        .padding([.top, .leading])
                        .onAppear {
                            Task {
                                let risk = await WeatherManager().getRiskLevel(coordinate: FirebaseManager.shared.groupMembersLocations[username] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                                riskLevel = risk
                                riskColor = getColor()
                            }
                    }
                }
            }.frame(width: circleWidth)
        }.frame(height: circleWidth)
    }
    
    private func getColor() -> Color {
        switch self.riskLevel {
        case 3:
            return .gray
        case 2:
            return .red
        case 1:
            return Color.accentYellow
        case 0:
            return Color.accentGreen
        default:
            return .gray
        }
    }
}

#Preview {
    MapMarker(image: Image(.children), username: "testadult", frameWidth: 100, circleWidth: 400, lineWidth: 8)
}
