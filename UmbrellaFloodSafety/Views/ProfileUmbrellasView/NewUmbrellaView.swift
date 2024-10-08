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
    @State private var opacity: Double = 0
    
    init(username: String) {
        self._viewModel = State(wrappedValue: NewUmbrellaViewViewModel(Username: username))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        
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
            .cornerRadius(25)
            .foregroundColor(.black)
            .font(.custom("Nunito", size: 18))
            .frame(height: 60)
            
            Spacer()
            
            UMButton(title: "Create Umbrella", background: .mainBlue) {
                viewModel.registerGroup()
                dismiss()
            }
            .frame(height: 60)
            
            Spacer()
            
        }
        .padding(.horizontal)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                opacity = 1
            }
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

#Preview {
    NewUmbrellaView(username: "Testadult")
}
