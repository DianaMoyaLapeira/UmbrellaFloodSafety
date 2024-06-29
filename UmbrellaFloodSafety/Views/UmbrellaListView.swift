//
//  UmbrellaListView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import SwiftUI

struct UmbrellaListView: View {
    var body: some View {
        NavigationLink(destination: NewUmbrellaView(username: "testadult")) {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text("Group Name")
                                .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                            
                            Spacer()
                        }
                        HStack {
                            Text("Testadult, testkid")
                                .font(.custom("Nunito", size: 18))
                            
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding(.leading)
                Divider()
            }
        }
    }
}

#Preview {
    UmbrellaListView()
}
