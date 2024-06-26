//
//  MapView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//
import FirebaseFirestore
import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var mainsheet: Bool = true
    @StateObject var viewModel: MapViewViewModel
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: MapViewViewModel(userId: userId))
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "bell")
            }
            .padding(.trailing)
            Spacer()
            HStack {
                Text("Hello Diana!")
                    .fontWeight(.black)
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(Color(.mainBlue))
                Spacer()
                Circle()
                    .frame(width: 40)
            }
            .padding()
            Map()
        }.sheet(isPresented: $mainsheet) {
            SheetView()
                .presentationDetents([.fraction(0.20), .large])
                .presentationDragIndicator(.visible)
        }
        .onAppear {
                    mainsheet = true
        }
    }
}

struct SheetView: View {
    var body: some View {
        VStack {
            Text("This is the sheet view")
                .font(.largeTitle)
                .padding()
            Button(action: {
                // Add any action you want here
            }) {
                Text("Action Button")
            }
        }
        .padding()
    }
}

#Preview {
    MapView(userId: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
