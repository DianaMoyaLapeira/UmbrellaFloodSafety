//
//  MakeEmergencyPlan.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/8/24.
//

import SwiftUI

struct MakeEmergencyPlan: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MakeEmergencyPlanViewModel
    @State var showAlert: Bool = false
    @State var showDeleteAlert: Bool = false
    @State private var opacity: Double = 0
    
    init(emergencyPlan: EmergencyPlanModel?) {
        self._viewModel = StateObject(wrappedValue: MakeEmergencyPlanViewModel(emergencyPlan: emergencyPlan))
    }
    
    var body: some View {
        
        HStack {
            Text(LocalizedStringKey("Edit Emergency Plan"))
                .font(.custom("Nunito", size: 34))
                .foregroundStyle(.mainBlue)
                .fontWeight(.black)
            
            Spacer()
        }
        .padding()
        
        Divider()
        
        ScrollView {
            
            HStack {
                Text(LocalizedStringKey("Plan Title:"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
                TextField(LocalizedStringKey("Plan Title"), text: $viewModel.title, prompt: Text(LocalizedStringKey("Enter Title"))
                    .font(.custom("Nunito", size: 24))
                    .bold()
                    .foregroundStyle(.gray)
                )
                .font(.custom("Nunito", size: 24))
                .foregroundStyle(.gray)
                .bold()
                .multilineTextAlignment(.leading)
            }
            
            Divider()
            
            NavigationLink(destination: EmergencyPlanUsersView(usersInPlan: $viewModel.usersInPlan)) {
                Text(LocalizedStringKey("Add or Remove Users"))
                    .font(.custom("Nunito", size: 18))
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).fill(.mainBlue).frame(width: 360, height: 60))
            }
            .padding(.vertical)
            
            Divider()
            
            HStack {
                Text(LocalizedStringKey("Family Member Contact Info"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding(.bottom)
            
            VStack {
                ForEach($viewModel.emergencyContacts) { $contact in
                    NavigationLink(destination: CreateEmergencyContact(emergencyContact: $contact, type: "emergencyContacts")) {
                        EmergencyContactListView(edit: true, emergencyContact: contact)
                            .padding()
                        
                    }
                    .foregroundStyle(.primary)
                    
                    Divider()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(Color.mainBlue))
            .frame(width: 358)
            .padding(.bottom)
            
            UMButton(title: "Add New Contact", background: .mainBlue) {
                viewModel.CreateEmergencyContact()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text(LocalizedStringKey("Pet Info"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            VStack {
                ForEach($viewModel.petEmergencyInfo) { $pet in
                    NavigationLink(destination: CreatePetEmergencyInfo( petEmergencyInfo: $pet)) {
                        PetInfoListView(edit: true, petEmergencyInfo: pet)
                            .padding()
                    }
                    .foregroundStyle(.primary)
                    
                    Divider()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 4)
                .fill(.mainBlue))
            .frame(width: 358)
            .padding(.bottom)
            
            UMButton(title: "Add New Pet", background: .mainBlue) {
                viewModel.CreatePetInfo()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text(LocalizedStringKey("Plan of Action"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text(LocalizedStringKey("The floods most likely to affect our home are: "))
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("Flash floods, coastal floods, etc."), text: $viewModel.mostLikelyDisasters, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text(LocalizedStringKey("What are the escape routes from our home?"))
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("Escape route from home"), text: $viewModel.escapeRouteFromHome, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text(LocalizedStringKey("If separated during an emergency, what is our meeting place near our home?"))
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("Meeting place near home"), text: $viewModel.meetingNearHome, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text(LocalizedStringKey("If we cannot return home or are asked to evacuate, what is our meeting place outside of our neighborhood?"))
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("Meeting place outside neighborhood"), text: $viewModel.meetingOutsideNeighborhood, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text(LocalizedStringKey("What is our route to get there?"))
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("First choice route"), text: $viewModel.firstChoiceRoute, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            HStack {
                Text(LocalizedStringKey("What is an alternate route to get there?"))
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("Second choice route"), text: $viewModel.secondChoiceRoute, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
            
            Divider()
                .padding(.top)
            
            HStack {
                Text(LocalizedStringKey("External Emergency Contacts"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            VStack {
                ForEach($viewModel.externalEmergencyContact) { $contact in
                    NavigationLink(destination: CreateEmergencyContact(emergencyContact: $contact, type: "externalEmergencyContacts")) {
                        EmergencyContactListView(edit: true, emergencyContact: contact)
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Divider()
                        
                    }
                }
                .foregroundStyle(.primary)
            }
            .foregroundStyle(.primary)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).foregroundStyle(Color.mainBlue))
            .frame(width: 358)
            .padding(.bottom)
            
            UMButton(title: "Add New Contact", background: .mainBlue) {
                viewModel.CreateExternalEmergencyContact()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text(LocalizedStringKey("Plans for Special Needs/Disabilities"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            VStack {
                ForEach($viewModel.specialNeedsEvacuationPlan) { $plan in
                    NavigationLink(destination: SpecialNeedsEvacuationPlanView(specialNeedsEvacuationPlan: $plan)) {
                        HStack {
                            VStack(alignment: .leading) {
                                if plan.name != "" {
                                    Text(plan.name)
                                        .font(.custom("Nunito", size: 24))
                                        .fontWeight(.black)
                                } else {
                                    Text(LocalizedStringKey("Click to Edit"))
                                        .font(.custom("Nunito", size: 24))
                                        .fontWeight(.black)
                                }
                                
                                if plan.plan != "" {
                                    Text(plan.plan)
                                        .font(.custom("Nunito", size: 18))
                                        .multilineTextAlignment(.leading)
                                } else {
                                    Text(LocalizedStringKey("Plan: None yet"))
                                        .font(.custom("Nunito", size: 18))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        
                    }
                    .foregroundStyle(.primary)
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 4)
                .fill(.mainBlue))
            .frame(width: 358)
            .padding(.bottom)
            
            UMButton(title: "Add New Plan", background: .mainBlue) {
                viewModel.CreateSpecialNeedsEvacuationPlan()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Text(LocalizedStringKey("Evacuation Plan for Children"))
                    .font(.custom("Nunito", size: 24))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            VStack {
                ForEach($viewModel.childEvacuationPlans) { $plan in
                    NavigationLink(destination: ChildEvacuationPlanView(childEvacuationPlanEx: $plan)) {
                        HStack {
                            VStack(alignment: .leading) {
                                if plan.name != "" {
                                    Text(plan.name)
                                        .font(.custom("Nunito", size: 24))
                                        .fontWeight(.black)
                                } else {
                                    Text("Click to edit")
                                        .font(.custom("Nunito", size: 24))
                                        .fontWeight(.black)
                                }
                                
                                if plan.evacuationSite != "" {
                                    Text("Evacuation site: \(plan.evacuationSite)")
                                        .font(.custom("Nunito", size: 18))
                                        .multilineTextAlignment(.leading)
                                } else {
                                    Text("Evacuation site: None yet")
                                        .font(.custom("Nunito", size: 18))
                                        .multilineTextAlignment(.leading)
                                }
                                
                                if plan.contactInfo != "" {
                                    Text("Contact Info: \(plan.contactInfo)")
                                        .font(.custom("Nunito", size: 18))
                                        .multilineTextAlignment(.leading)
                                } else {
                                    Text("Evacuation site: None yet")
                                        .font(.custom("Nunito", size: 18))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                    }
                    .foregroundStyle(.primary)
                    
                    Divider()
                }.foregroundStyle(.primary)
            }
            .foregroundStyle(.primary)
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 4)
                .fill(.mainBlue))
                .frame(width: 358)
                .padding(.bottom)
            
            UMButton(title: "Add New Plan", background: .mainBlue) {
                viewModel.CreateChildEvacuationPlan()
            }
            .frame(height: 60)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("Safe Room"))
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Text(LocalizedStringKey("What is an accessible, safe room where we can go, seal windows, vents and doors and listen to emergency broadcasts for instructions?"))
                        .font(.custom("Nunito", size: 18))
                        .bold()
                }
                
                Spacer()
            }
            
            TextField(LocalizedStringKey("Safe room"), text: $viewModel.safeRoom, axis: .vertical)
                .foregroundStyle(.secondary)
                .font(.custom("Nunito", size: 18))
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.quinary))
                .padding(.bottom)
            
            Divider()
            
            UMButton(title: "Delete Plan", background: .red) {
                showDeleteAlert = true
            }
            .frame(height: 60)
            .padding(.vertical)
            
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                opacity = 1
            }
        }
        .padding()
        .alert(LocalizedStringKey("Go back without saving?"), isPresented: $showAlert) {
            Button(LocalizedStringKey("Back"), role: .destructive) {
                dismiss()
            }
            Button(LocalizedStringKey("Cancel"), role: .cancel) { }
        }
        .alert(LocalizedStringKey("Delete plan?"), isPresented: $showDeleteAlert) {
            Button(LocalizedStringKey("Delete"), role: .destructive) {
                viewModel.deleteEmergencyPlan()
                dismiss()
            }
            Button(LocalizedStringKey("Cancel"), role: .cancel) { }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
           ToolbarItem(placement: .topBarLeading) {
               Button {
                   showAlert.toggle()
               } label: {
                   Text(LocalizedStringKey("Back"))
                       .font(.custom("Nunito", size: 18))
                       .foregroundStyle(.mainBlue)
                       .fontWeight(.bold)
               }

           }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.uploadEmergencyPlanIntoDB()
                    dismiss()
                } label: {
                    Text(LocalizedStringKey("Done"))
                        .font(.custom("Nunito", size: 18))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    MakeEmergencyPlan(emergencyPlan: nil)
}
