//
//  MessagingView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct MessagingView: View {
    @StateObject var viewModel: MessagingViewViewModel
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: MessagingViewViewModel(userId: userId))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MessagingView(userId: "vZAFWKrRyFh0oNfXBr3adVTUNQD3")
}
