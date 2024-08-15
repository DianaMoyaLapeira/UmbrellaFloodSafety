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
                    
                    Text("Create A New Umbrella")
                        .multilineTextAlignment(.center)
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
                
                TextField("Umbrella Name", text: $viewModel.groupName, prompt: Text("Umbrella Name")
                    .foregroundStyle(Color(.darkGray)))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
                .font(.custom("Nunito", size: 18))
                .frame(width: 300, height: 60)
                
                Spacer()
                
                UMButton(title: "Create Umbrella", background: .mainBlue) {
                    viewModel.registerGroup()
                    dismiss()
                }
                .frame(width: 300, height: 60)
                
                Spacer()
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18)
                    }
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
