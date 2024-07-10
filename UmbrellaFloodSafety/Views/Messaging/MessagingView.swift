//
//  MessagingView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct MessagingView: View {
    @StateObject var viewModel = MessagingViewViewModel.shared
    @State var showNotificationSheet: Bool = false
    
    init() {
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Messages")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(Color.mainBlue)
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
                
                Divider()
                
                ScrollView {
                    NavigationLink(destination: ConversationView()) {
                        MessagingListItem()
                            .padding(.leading)
                    }
                    
                    Divider()
                        .padding([.leading, .trailing])
                }
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    MessagingView()
}
