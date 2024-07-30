//
//  RegisterFirstView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI

struct RegisterFirstView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
           VStack {
               Spacer()
               
               Text("Create Your \nAccount")
                   .font(.custom("Nunito", size: 40))
                   .scaledToFill()
                   .fontWeight(.black)
                   .foregroundStyle(Color(.mainBlue))
                   .padding(.top)
                   .multilineTextAlignment(.center)
                   
               Spacer()
               
               VStack (spacing: 0){
                   Image(.children)
                       .resizable()
                       .scaledToFit()
                       .frame(height: 220)
                   
                   ZStack {
                       RoundedRectangle(cornerRadius: 25)
                           .foregroundStyle(Color(.mainBlue))
                       NavigationLink("I'm A Kid", destination: KidRegisterView())
                           .foregroundStyle(Color(.white))
                           .fontWeight(.bold)
                           .font(.custom("Nunito", size: 18))
                   }
                   .frame(width: 300, height: 60)
               }
               
               VStack (spacing: 0) {
                   Image(.adultWoman)
                       .resizable()
                       .scaledToFit()
                       .frame(height: 220)
                   ZStack {
                       RoundedRectangle(cornerRadius: 25)
                           .stroke(Color(.mainBlue), lineWidth: 4)
                       NavigationLink("I'm An Adult", destination: AdultRegisterView())
                           .foregroundStyle(Color(.mainBlue))
                           .fontWeight(.bold)
                           .font(.custom("Nunito", size: 18))
                   }
                   .frame(width: 300, height: 60)
               }
               Spacer()
           }
           .navigationBarBackButtonHidden(true)
           .toolbar {
               ToolbarItem(placement: .topBarLeading) {
                   Button(action: {
                       dismiss()
                   }) {
                       Label {
                            Text("Back")
                       } icon: {
                           Image(.backArrow)
                                       }
                   }
                   .padding()
               }
               ToolbarItemGroup(placement: .principal) {
                   Image(.oneThirdProgress)
               }
           }
       }
}

#Preview {
    RegisterFirstView()
}
