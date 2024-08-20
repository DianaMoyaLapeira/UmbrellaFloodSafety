//
//  ConversationView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/7/24.
//

import SwiftUI

struct ConversationView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var sendTapped: Bool = false
    @State private var opacity: Double = 0
    @StateObject var viewModel: ConversationViewViewModel
    @ObservedObject var firebaseManager = FirebaseManager.shared
    var conversationId: String = ""
    var username: [String] = []
    var name: String {
        return firebaseManager.usernameToName[username[0]] ?? ""
    }
    var messagessOrdered: [message] {
        let messages = firebaseManager.messages[viewModel.conversationId]?.sorted { $0.timestamp < $1.timestamp
        } ?? []
        
        return messages
    }
 
    
    init(conversationId: String, username: [String]) {
        self.username = username.filter({ username in
            username != FirebaseManager.shared.currentUserUsername
        })
        self._viewModel = StateObject(wrappedValue: ConversationViewViewModel(conversationId: conversationId))
    }
    
    var body: some View {
        VStack {
            NavigationLink {
                UserView(username: username[0])
            } label: {
                HStack {
                    MapMarker(profileString: firebaseManager.groupMembersAvatars[username[0]] ?? "", username: username[0], frameWidth: 20, circleWidth: 60, lineWidth: 4, paddingPic: 5)
                    
                    if name != "" {
                        VStack {
                            HStack {
                                Text("\(name)")
                                    .font(.custom("Nunito", size: 24))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.mainBlue)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("\(username.joined(separator: ", "))")
                                    .font(.custom("Nunito", size: 18))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.secondary)
                                
                                Spacer()
                            }
                        }
                        .padding(.leading, 3)
                    } else {
                        HStack {
                            Text("\(username.joined(separator: ", "))")
                                .font(.custom("Nunito", size: 24))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.mainBlue)
                            
                            Spacer()
                        }
                        .padding(.leading, 3)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)

                }
                .padding()
            }
            
            Divider()
            
            ScrollViewReader { proxy in
                ScrollView {
                    
                    if messagessOrdered.count != 0 {
                        LazyVStack {
                            ForEach(messagessOrdered, id: \.self) { message in
                                TextMessageView(content: message.content, timestamp: message.timestamp, senderId: message.senderId)
                            }
                        }
                        
                        if viewModel.suggestionsFormatted.count != 0 {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(viewModel.suggestionsFormatted, id: \.self) { suggestion in
                                        
                                        Button {
                                            viewModel.sendMessage(input: suggestion)
                                        } label: {
                                            suggestionView(suggestion: suggestion)
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .transition(.move(edge: .bottom))
                                .animation(.easeOut(duration: 0.5), value: viewModel.suggestionsFormatted.count)
                            }
                        }
                        
                    } else {
                        Image(.conversationEmptyState)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 170)
                            .padding()
                        
                        Text("No messages yet. Try sending some!")
                            .font(.custom("Nunito", size: 18))
                            .bold()
                            .foregroundStyle(.black)
                    }
                    
                    HStack {
                        TextField("text message", text: $viewModel.input, prompt: Text("Message").font(.custom("Nunito", size: 18)).foregroundStyle(Color.secondary))
                            .scrollDismissesKeyboard(.immediately)
                            .onSubmit {
                                viewModel.sendMessage(input: viewModel.input)
                                viewModel.input = ""
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(Color.gray.opacity(0.2)))
                            .padding([.leading, .top, .bottom])
                        
                        Button {
                            viewModel.sendMessage(input: viewModel.input)
                            
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaleEffect(sendTapped ? 0.9 : 1)
                                .animation(.spring, value: sendTapped)
                                .foregroundStyle(Color.mainBlue)
                                .padding([.leading, .top, .trailing])
                        }

                    }
                    .padding(.bottom)
                    .id(888)
                }
                .onAppear {
                    proxy.scrollTo(888, anchor: .bottom)
                    
                    UIScrollView.appearance().keyboardDismissMode = .interactive
                }
                .onChange(of: firebaseManager.messages[viewModel.conversationId]) {
                    if messagessOrdered.last?.senderId != firebaseManager.currentUserUsername && messagessOrdered.last?.senderId != nil && messagessOrdered.last?.senderId != "" {
                        viewModel.getSuggestions(input: messagessOrdered.last?.content ?? "")
                    }
                    
                    withAnimation {
                        proxy.scrollTo(888, anchor: .bottom)
                    }
                }
                .onAppear {
                    if messagessOrdered.last?.senderId != firebaseManager.currentUserUsername {
                        viewModel.getSuggestions(input: messagessOrdered.last?.content ?? "")
                    }

                }
                .transition(.move(edge: .bottom))
                .animation(.easeOut, value: viewModel.suggestionsFormatted)
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
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
       }
    }
}

#Preview {
    ConversationView(conversationId: "", username: [])
}
