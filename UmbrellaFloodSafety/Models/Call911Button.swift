//
//  Call911Button.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 17/7/24.
//

import SwiftUI

struct Call911Button: View {
    @State var showAlert = false
    
    var body: some View {
        
        Button {
            showAlert = true
        } label: {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(.red)
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 20)
                        
                        Text("Call 911")
                            .foregroundStyle(.white)
                            .font(.custom("Nunito", size: 18))
                            .bold()
                    }
                }
                .frame(width: 155, height: 44)
        }
        .padding(.trailing)
        .alert("Call 911?", isPresented: $showAlert) {
            Button("Call 911", role: .destructive) {
                guard let url = URL(string: "tel://911") else { return }
                UIApplication.shared.open(url)
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}

#Preview {
    Call911Button()
}
