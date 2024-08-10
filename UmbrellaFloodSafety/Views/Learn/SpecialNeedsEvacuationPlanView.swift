//
//  SpecialNeedsEvacuationPlanView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/8/24.
//

import SwiftUI

struct SpecialNeedsEvacuationPlanView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var specialNeedsEvacuationPlan: SpecialNeedsEvacuationPlan
    
    var body: some View {
        VStack {
            
            HStack {
                
                Text("New Special Needs/Disabilities Plan")
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
                
                TextField("Enter name", text: $specialNeedsEvacuationPlan.name)
                    .foregroundStyle(.secondary)
                    .font(.custom("Nunito", size: 18))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(.quinary))
                
                HStack {
                    
                    Text("Plan")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                }
                
                TextField("Enter evacuation plan", text: $specialNeedsEvacuationPlan.plan, axis: .vertical)
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
    struct SpecialNeedsEvacuationPlanViewContainer: View {
        @State private var examplePlan = SpecialNeedsEvacuationPlan(id: UUID().uuidString, name: "Click to edit", plan: "Plan")
        
        var body: some View {
            SpecialNeedsEvacuationPlanView(specialNeedsEvacuationPlan: $examplePlan)
        }
    }
    
    return SpecialNeedsEvacuationPlanViewContainer()
}
