//
//  ReportView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/7/24.
//

import SwiftUI

struct ReportView: View {
    
    @Binding var isPresented: Bool
    @StateObject var viewModel = UserViewViewModel()
    let sender: String
    let reported: String
    @State var reason: String = ""
    
    init(isPresented: Binding<Bool>, sender: String, reported: String) {
        self._isPresented = isPresented
        self.sender = sender
        self.reported = reported
    }
 
    var body: some View {
        VStack {
            
            HStack {
                Text(LocalizedStringKey("Report A User"))
                    .font(.custom("Nunito", size: 34))
                    .fontWeight(.black)
                    .foregroundStyle(.red)
                
                Spacer()
                
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34)
                        .foregroundStyle(.red)
                }
            }
            
            Image(systemName: "bubble.left.and.exclamationmark.bubble.right.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.red)
                .frame(width: 100)
            
            HStack {
                Text("We are sorry that you've had a bad experience with user\(reported). \n\nPlease let us know why so we can take appropriate measures.")
                    .font(.custom("Nunito", size: 18))
                
                Spacer()
            }
            .padding(.vertical)
            
            TextField(LocalizedStringKey("Reason for reporting"), text: $reason, prompt: Text(LocalizedStringKey("Type reason for reporting here")).font(.custom("Nunito", size: 18)).foregroundStyle(.black))
                .multilineTextAlignment(.leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).fill(.quinary))
                .padding(.vertical)
            
            UMButton(title: "Submit", background: .red) {
                viewModel.reportUser(sender: sender, reported: reported, reason: reason)
                
                isPresented.toggle()
            }
            .frame(height: 60)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    struct ReportViewContainer: View {
        @State private var isPresented = false
        
        var body: some View {
            ReportView(isPresented: $isPresented, sender: "Sender", reported: "reported")
        }
    }
    
    return ReportViewContainer()
}
