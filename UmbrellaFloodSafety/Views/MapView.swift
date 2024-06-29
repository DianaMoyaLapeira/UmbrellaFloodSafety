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
    
    @State private var showSheet: Bool = true
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
            ZStack {
                Map()
                VStack {
                    
                    HStack {
                        Text("GroupName")
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(width: 250, height: 40, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
                        
                        Spacer()
                    }.padding(.top)
                        .padding(.leading)
                                        
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .bottom) {
                    if showSheet {
                        MapViewSheet()
                            .transition(.move(edge: .bottom))
                    }
                }
                .animation(.easeInOut, value: showSheet)
    }
}



#Preview {
    MapView(userId: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
