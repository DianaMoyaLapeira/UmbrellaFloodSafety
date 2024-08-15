//
//  CreateEmergencyContact.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/8/24.
//

import SwiftUI

struct CreateEmergencyContact: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var emergencyContact: EmergencyContact
    @State private var opacity: Double = 0
    
    var body: some View {
    
        VStack {
                
            HStack {
                
                Text("New Family Emergency Contact")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
            }
            
            Divider()
                
            ScrollView {
                
                HStack {
                    
                    Text("Name")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter name", text: $emergencyContact.name)
                    .foregroundStyle(.secondary)
                    .font(.custom("Nunito", size: 18))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.quinary))
                
                
                HStack {
                    
                    Text("Home Phone Number (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter home phone number", text: $emergencyContact.homePhoneNumber)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .onChange(of: emergencyContact.homePhoneNumber) {
                        if !emergencyContact.homePhoneNumber.isEmpty {
                            emergencyContact.homePhoneNumber = emergencyContact.homePhoneNumber.formatPhoneNumber()
                        }
                    }
                    .foregroundStyle(.secondary)
                    .font(.custom("Nunito", size: 18))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.quinary))
                
                HStack {
                    
                    Text("Cell Phone Number (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter cell phone number", text: $emergencyContact.cellPhoneNumber)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .onChange(of: emergencyContact.cellPhoneNumber) {
                        if !emergencyContact.cellPhoneNumber.isEmpty {
                            emergencyContact.cellPhoneNumber = emergencyContact.cellPhoneNumber.formatPhoneNumber()
                        }
                    }
                    .foregroundStyle(.secondary)
                    .font(.custom("Nunito", size: 18))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.quinary))
                
                HStack {
                    
                    Text("Email address (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter email address", text: $emergencyContact.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
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
    struct CreateEmergencyContactViewContainer: View {
        @State private var exampleContact = EmergencyContact(id: UUID().uuidString, name: "Name", homePhoneNumber: "nil", cellPhoneNumber: "000000000", email: "email@domain.com")
        
        var body: some View {
            CreateEmergencyContact(emergencyContact: $exampleContact)
        }
    }
    
    return CreateEmergencyContactViewContainer()
}
