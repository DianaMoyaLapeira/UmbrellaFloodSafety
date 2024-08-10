//
//  MakeEmergencyPlan.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/8/24.
//

import SwiftUI

struct MakeEmergencyPlan: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = MakeEmergencyPlanViewModel()
    
    var body: some View {
        
        HStack {
            Text("Edit Emergency Plan")
                .font(.custom("Nunito", size: 34))
                .foregroundStyle(.mainBlue)
                .fontWeight(.black)
            
            Spacer()
        }
        .padding()
        
        Divider()
        
        ScrollView {
            
            HStack {
                Text("Plan Title:")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
                TextField("Plan Title", text: $viewModel.title, prompt: Text("Enter Title")
                    .font(.custom("Nunito", size: 24))
                    .bold()
                    .foregroundStyle(.gray)
                )
                .font(.custom("Nunito", size: 24))
                .foregroundStyle(.mainBlue)
                .multilineTextAlignment(.leading)
            }
            
            Divider()
            
            HStack {
                Text("Family Member Contact Info")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding(.bottom)
            
            VStack {
                ForEach($viewModel.emergencyContacts) { $contact in
                    NavigationLink(destination: CreateEmergencyContact( emergencyContact: $contact)) {
                        EmergencyContactListView(emergencyContact: contact)
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Divider()
                        
                    }
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 6).foregroundStyle(Color.mainBlue))
            
            UMButton(title: "Add New Contact", background: .mainBlue) {
                viewModel.CreateEmergencyContact()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text("Pet Info")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            ForEach($viewModel.petEmergencyInfo) { $pet in
                NavigationLink(destination: CreatePetEmergencyInfo( petEmergencyInfo: $pet)) {
                    PetInfoListView(petEmergencyInfo: pet )
                        .foregroundStyle(.primary)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 4)
                            .fill(.mainBlue))
                            .frame(width: 358)
                            .padding(.bottom)
                }
            }
            
            UMButton(title: "Add New Pet", background: .mainBlue) {
                viewModel.CreatePetInfo()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text("Plan of Action")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text("1. The floods most likely to affect our home are: (optional)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField("Flash floods, coastal floods, etc.", text: $viewModel.mostLikelyDisasters, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text("2. What are the escape routes from our home? (optional)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField("Escape route from home", text: $viewModel.escapeRouteFromHome, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text("3. If separated during an emergency, what is our meeting place near our home? (optional)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField("Meeting place near home", text: $viewModel.meetingNearHome, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text("4. If we cannot return home or are asked to evacuate, what is our meeting place outside of our neighborhood? (optional)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField("Meeting place outside neighborhood", text: $viewModel.meetingOutsideNeighborhood, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text("What is our route to get there? (optional)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField("First choice route", text: $viewModel.firstChoiceRoute, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text("What is an alternate route to get there? (optional)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField("Second choice route", text: $viewModel.secondChoiceRoute, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            Divider()
                .padding(.top)
            
            HStack {
                Text("External Emergency Contacts")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            ForEach($viewModel.externalEmergencyContact) { $contact in
                NavigationLink(destination: CreateEmergencyContact( emergencyContact: $contact)) {
                    EmergencyContactListView(emergencyContact: contact)
                        .foregroundStyle(.primary)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 4)
                            .fill(.mainBlue))
                            .frame(width: 358)
                            .padding(.bottom)
                }
            }
            
            UMButton(title: "Add New Contact", background: .mainBlue) {
                viewModel.CreateExternalEmergencyContact()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text("Plans for Special Needs/Disabilities")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            ForEach($viewModel.specialNeedsEvacuationPlan) { $plan in
                NavigationLink(destination: SpecialNeedsEvacuationPlanView(specialNeedsEvacuationPlan: $plan)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Title")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.black)
                            
                            Text("Plan")
                                .font(.custom("Nunito", size: 18))
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.primary)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 4)
                        .fill(.mainBlue))
                        .frame(width: 358)
                        .padding(.bottom)
                }
            }
            
            UMButton(title: "Add New Plan", background: .mainBlue) {
                viewModel.CreateSpecialNeedsEvacuationPlan()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text("Evacuation Plan for Children")
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            ForEach($viewModel.childEvacuationPlans) { $plan in
                NavigationLink(destination: ChildEvacuationPlanView(childEvacuationPlanEx: $plan)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Title")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.black)
                            
                            Text("Evacuation site")
                                .font(.custom("Nunito", size: 18))
                                .multilineTextAlignment(.leading)
                            
                            Text("Contact info")
                                .font(.custom("Nunito", size: 18))
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.primary)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 4)
                        .fill(.mainBlue))
                        .frame(width: 358)
                        .padding(.bottom)
                }
            }
            
            UMButton(title: "Add New Plan", background: .mainBlue) {
                viewModel.CreateChildEvacuationPlan()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Safe Room")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Text("What is an accessible, safe room where we can go, seal windows, vents and doors and listen to emergency broadcasts for instructions?")
                        .font(.custom("Nunito", size: 18))
                }
                
                Spacer()
            }
            
            TextField("Safe room", text: $viewModel.safeRoom, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.uploadEmergencyPlanIntoDB()
                } label: {
                    Text("Done")
                        .font(.custom("Nunito", size: 18))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    MakeEmergencyPlan()
}
