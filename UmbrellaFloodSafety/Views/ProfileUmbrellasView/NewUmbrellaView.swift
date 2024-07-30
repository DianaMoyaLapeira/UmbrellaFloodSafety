//
//  NewUmbrellaView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import SwiftUI

struct NewUmbrellaView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var viewModel: NewUmbrellaViewViewModel
    
    init(username: String) {
        self._viewModel = State(wrappedValue: NewUmbrellaViewViewModel(Username: username))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Create A New Group")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(Color(.mainBlue))
                    
                    Spacer()
                }
                .padding()
                
                Image(.umbrellaEmptyState)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 300)
                
                TextField("Group Name", text: $viewModel.groupName, prompt: Text("Group Name")
                    .foregroundStyle(Color(.darkGray)))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
                .font(.custom("Nunito", size: 18))
                .frame(width: 300, height: 60)
                
                Spacer()
                
                UMButton(title: "Create Group", background: .mainBlue) {
                    viewModel.registerGroup()
                }
                .frame(width: 300, height: 60)
                
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
                ToolbarItem(placement: .principal) {
                    Image(.halfProgress)
                }
            }
        }
    }
}

#Preview {
    NewUmbrellaView(username: "Testadult")
}
