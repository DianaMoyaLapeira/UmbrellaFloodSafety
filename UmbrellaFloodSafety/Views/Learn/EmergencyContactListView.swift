//
//  EmergencyContactListView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/8/24.
//

import SwiftUI

struct EmergencyContactListView: View {
    
    let edit: Bool = false
    var emergencyContact: EmergencyContact = EmergencyContact(id: UUID().uuidString, name: "Click To Edit")
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading) {
                
                if emergencyContact.name == "" {
                    Text("Click to edit")
                        .font(.custom("Nunito", size: 24))
                        .fontWeight(.black)
                } else {
                    Text(emergencyContact.name)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 24))
                        .fontWeight(.black)
                }
                
                if emergencyContact.homePhoneNumber == "" {
                    Text("Home Phone: None yet")
                        .font(.custom("Nunito", size: 18))
                } else {
                    Text("Home Phone: \(emergencyContact.homePhoneNumber.formatPhoneNumber())")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                }
                
                
                if emergencyContact.cellPhoneNumber == "" {
                    Text("Cell Phone: None yet")
                        .font(.custom("Nunito", size: 18))
                } else {
                    Text("Cell Phone: \(emergencyContact.cellPhoneNumber.formatPhoneNumber())")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                }
                
                if emergencyContact.email == "" {
                    Text("Email address: None yet")
                        .font(.custom("Nunito", size: 18))
                } else {
                    Text("Email: \(emergencyContact.email)")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                }
                
            }
            
            Spacer()
            
            if edit {
                Image(systemName: "chevron.right")
            }
        }
    }
}

#Preview {
    EmergencyContactListView()
}
