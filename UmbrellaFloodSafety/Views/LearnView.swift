//
//  LearnView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct LearnView: View {
    @StateObject var viewModel: LearnViewViewModel
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: LearnViewViewModel(userId: userId))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LearnView(userId: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
