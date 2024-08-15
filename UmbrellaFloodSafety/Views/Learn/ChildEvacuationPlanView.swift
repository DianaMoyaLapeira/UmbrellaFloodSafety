//
//  ChildEvacuationPlanView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/8/24.
//

import SwiftUI

struct ChildEvacuationPlanView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var childEvacuationPlanEx: childEvacuationPlan
    @State private var opacity: Double = 0
    
    var body: some View {
        VStack {
            
            HStack {
                
                Text("New Child Evacuation Plan")
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
                
            }
            
            Divider()
            
            ScrollView {
                
                HStack {
                    
                    Text("Plan Name")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter name", text:$childEvacuationPlanEx.name)
                    .foregroundStyle(.secondary)
                    .font(.custom("Nunito", size: 18))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.quinary))
                
                HStack {
                    
                    Text("Evacuation Site")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter evacuation site", text: $childEvacuationPlanEx.evacuationSite, axis: .vertical)
                    .foregroundStyle(.secondary)
                    .font(.custom("Nunito", size: 18))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.quinary))
                
                HStack {
                    
                    Text("Contact Info (optional)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter contact info", text: $childEvacuationPlanEx.contactInfo)
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
    struct ChildEvacuationPlanViewContainer: View {
        @State private var examplePlan = childEvacuationPlan(id: UUID().uuidString, name: "Plan name", evacuationSite: "Evacuation site")
        
        var body: some View {
            ChildEvacuationPlanView(childEvacuationPlanEx: $examplePlan)
        }
    }
    
    return ChildEvacuationPlanViewContainer()
}
