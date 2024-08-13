//
//  EmergencyPlanView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/10/24.
//

import SwiftUI

struct EmergencyPlanView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var emergencyPlan: EmergencyPlanModel
    @State var isPresented: Bool = false
    var actualtimestamp: String {
        guard emergencyPlan.dateUpdated != 0 else {
            return ""
        }
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: emergencyPlan.dateUpdated)
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(emergencyPlan.title)
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding([.top, .horizontal])
            
            HStack {
                Text("Last updated \(actualtimestamp)")
                    .font(.custom("Nunito", size: 18))
                    .bold()
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            .padding([.bottom, .horizontal])
            
            Divider()
            
            ScrollView {
                
                UMButton(title: "Who's In This Plan?", background: .mainBlue) {
                    isPresented.toggle()
                }
                .frame(height: 60)
                .padding(.bottom)
                
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
                    ForEach(emergencyPlan.emergencyContacts) { contact in
                        EmergencyContactListView(emergencyContact: contact)
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Divider()
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
                .frame(width: 358)
                .padding(.bottom)
                
                Divider()
                
                HStack {
                    Text("Pet Info")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                
                VStack {
                    ForEach(emergencyPlan.petEmergencyInfo) { pet in
                        PetInfoListView(petEmergencyInfo: pet )
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Divider()
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
                .frame(width: 358)
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
                
                if emergencyPlan.mostLikelyDisasters != "" {
                    HStack {
                        Text("The floods most likely to affect our home are:")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(emergencyPlan.mostLikelyDisasters)
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                
                if emergencyPlan.escapeRouteFromHome != "" {
                    HStack {
                        Text("What are the escape routes from our home?")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(emergencyPlan.escapeRouteFromHome)
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                
                if emergencyPlan.meetingNearHome != "" {
                    HStack {
                        Text("If separated during an emergency, what is our meeting place near our home?")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(emergencyPlan.meetingNearHome)
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                
                if emergencyPlan.meetingOutsideNeighborhood != "" {
                    HStack {
                        Text("If we cannot return home or are asked to evacuate, what is our meeting place outside of our neighborhood?")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(emergencyPlan.meetingOutsideNeighborhood)
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                
                if emergencyPlan.firstChoiceRoute != "" {
                    HStack {
                        Text("What is our route to get there?")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(emergencyPlan.firstChoiceRoute)
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                
                if emergencyPlan.secondChoiceRoute != "" {
                    HStack {
                        Text("What is an alternate route to get there?")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(emergencyPlan.secondChoiceRoute)
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                
                Divider()
                
                HStack {
                    Text("External Emergency Contacts")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                .padding(.bottom)
                
                VStack {
                    ForEach(emergencyPlan.externalEmergencyContact) { contact in
                        EmergencyContactListView(emergencyContact: contact)
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Divider()
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
                .frame(width: 358)
                .padding(.bottom)
                
                Divider()
                
                HStack {
                    Text("Plans for Special Needs/Disabilities")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                
                VStack {
                    ForEach(emergencyPlan.specialNeedsEvacuationPlan) { plan in
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    if plan.name != "" {
                                        Text(plan.name)
                                            .font(.custom("Nunito", size: 24))
                                            .fontWeight(.black)
                                    } else {
                                        Text("Click to Edit")
                                            .font(.custom("Nunito", size: 24))
                                            .fontWeight(.black)
                                    }
                                    
                                    if plan.plan != "" {
                                        Text(plan.plan)
                                            .font(.custom("Nunito", size: 18))
                                            .multilineTextAlignment(.leading)
                                    } else {
                                        Text("Plan: None yet")
                                            .font(.custom("Nunito", size: 18))
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(.primary)
                            
                            Divider()
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
                .frame(width: 358)
                .padding(.bottom)
                
                Divider()
                
                HStack {
                    Text("Evacuation Plan for Children")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                
                VStack {
                    ForEach(emergencyPlan.childEvacuationPlans) { plan in
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
                            .foregroundStyle(.primary)
                            .padding()
                        
                        Divider()
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(.mainBlue))
                    .frame(width: 358)
                    .padding(.bottom)
                
            }
            .padding()
        }
        .sheet(isPresented: $isPresented, content: {
            
            HStack {
                Text("People In Plan")
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34)
                }
            }
            .padding()
            
            Divider()
                
            Spacer()
            
            ScrollView {
                VStack {
                    ForEach(emergencyPlan.usersInPlan, id: \.self) { member in
                        
                        NavigationLink(destination: UserView(username: member)) {
                            MessagingListItem(participants: [member], timestamp: 0, lastMessage: member)
                        }
                        
                        Divider()
                    }
                }
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 4).fill(.mainBlue))
                .padding(2)
            }
            .padding()
        })
        .navigationBarBackButtonHidden(true)
        .toolbar {
           ToolbarItem(placement: .topBarLeading) {
               Button {
                   dismiss()
               } label: {
                   Image(.backArrow)
               }

           }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: MakeEmergencyPlan(emergencyPlan: emergencyPlan)) {
                    Text("Edit")
                        .font(.custom("Nunito", size: 18))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    EmergencyPlanView(emergencyPlan: EmergencyPlanModel(id: UUID().uuidString, title: "Plan title", dateUpdated: 1723333274, emergencyContacts: [], petEmergencyInfo: [], mostLikelyDisasters: "Most likely", escapeRouteFromHome: "escape route from home", meetingNearHome: "meeting near home", meetingOutsideNeighborhood: "meeting outside neighborhood", firstChoiceRoute: "first choice route", secondChoiceRoute: "second choice route", externalEmergencyContact: [], childEvacuationPlans: [], specialNeedsEvacuationPlan: [], safeRoom: "Safe room", usersInPlan: []))
}
