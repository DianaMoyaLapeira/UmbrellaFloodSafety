//
//  WeatherTest.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 26/6/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct WeatherTest: View {
    @State private var viewModel = WeatherManager()
    let jakarta = CLLocationCoordinate2D(latitude: 43.6208, longitude: -94.9851)
    @State var riskLevel: Int = 0
    var body: some View {
        VStack {
            Text("\(riskLevel)")
        }
        .onAppear {
            Task {
                riskLevel = await viewModel.getRiskLevel(coordinate: jakarta)
            }
        }
    }
}

#Preview {
    WeatherTest()
}
