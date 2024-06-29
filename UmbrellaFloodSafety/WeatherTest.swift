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
    let jakarta = CLLocation(latitude: 43.6208, longitude: -94.9851)
    var body: some View {
        VStack {
            Text("\(viewModel.floodWarnings)")
        }
        .onAppear {
            Task {
                await viewModel.getWeather(lat: jakarta.coordinate.latitude,
                                           long: jakarta.coordinate.longitude)
            }
        }
    }
}

#Preview {
    WeatherTest()
}
