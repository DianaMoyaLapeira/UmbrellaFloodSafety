//
//  CreatePetEmergencyInfo.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/8/24.
//

import SwiftUI

struct CreatePetEmergencyInfo: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var petEmergencyInfo: PetEmergencyInfo
    @State private var opacity: Double = 0
    
    var body: some View {
    
        VStack {
            
            HStack {
                
                Text("New Pet Emergency Info")
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
            }
            
            Divider()
            
            ScrollView {
                
                HStack {
                    
                    Text("Name (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter name", text: $petEmergencyInfo.name)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
                
                HStack {
                    
                    Text("Type (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter type", text: $petEmergencyInfo.type)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
                
                HStack {
                    
                    Text("Color (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter color", text: $petEmergencyInfo.color)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
                
                HStack {
                    
                    Text("Registration # (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter registration #", text: $petEmergencyInfo.registrationNumber)
                    .keyboardType(.numbersAndPunctuation)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
                
                UMButton(title: "Done", background: .mainBlue) {
                    dismiss()
                }
                .frame(height: 60)
                .padding(.vertical)
                
                Spacer()
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                opacity = 1
            }
        }
        .padding()
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
       }
    }
}

#Preview {
    struct CreatePetEmergencyInfoViewContainer: View {
        @State private var examplePet = PetEmergencyInfo(id: UUID().uuidString)
        
        var body: some View {
            CreatePetEmergencyInfo(petEmergencyInfo: $examplePet)
        }
    }
    
    return CreatePetEmergencyInfoViewContainer()
}
