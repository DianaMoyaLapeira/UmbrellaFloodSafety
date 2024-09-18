//
//  AddUsersToPlanSheet.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/10/24.
//

import SwiftUI

struct AddUsersToPlanSheet: View {
    
    @Binding var usersInPlan: [String]
    @Binding var isPresented: Bool
    @StateObject var firebaseManager = FirebaseManager.shared
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Add Members")
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
                        .foregroundStyle(.mainBlue)
                        .frame(width: 34)
                }
            }
            
            Divider()
            
            ForEach(firebaseManager.groupMembers.keys.sorted(), id: \.self) { group in
                
                HStack {
                    Text(firebaseManager.userGroups[group] ?? "Umbrella \(group)")
                        .font(.custom("Nunito", size: 24))
                        .foregroundStyle(.mainBlue)
                        .fontWeight(.black)
                    
                    Spacer()
                }
                
                VStack {
                    ForEach(firebaseManager.groupMembers[group] ?? [], id: \.self) { member in
                        memberItemView(for: member)
                            .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 4)
                .fill(.mainBlue))
                .padding(2)
            }
        }
        .padding()
    }
    
    // split it to optimize it so the preview works/avoid warnings
    
    private func memberItemView(for member: String) -> some View {
        ZStack(alignment: .trailing) {
            MessagingListItem(participants: [member], timestamp: 0, lastMessage: member)

            if usersInPlan.contains(member) {
                UMButton(title: "Remove", background: .red) {
                    usersInPlan.removeAll { $0 == member }
                }
                .frame(width: 100, height: 60)
            } else {
                UMButton(title: "Add", background: .mainBlue) {
                    usersInPlan.append(member)
                }
                .frame(width: 100, height: 60)
            }
        }
    }
}

#Preview {
    struct AddUsersToPlanSheetContainer: View {
        @State private var isPresented: Bool = false
        @State private var usersInPlan: [String] = ["user1", "user2"]
        
        var body: some View {
            AddUsersToPlanSheet(usersInPlan: $usersInPlan, isPresented: $isPresented)
        }
    }
    
    return AddUsersToPlanSheetContainer()
}

