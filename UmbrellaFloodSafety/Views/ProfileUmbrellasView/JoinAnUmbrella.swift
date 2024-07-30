//
//  JoinAnUmbrella.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 1/7/24.
//

import SwiftUI

struct JoinAnUmbrella: View {
    
    enum CharacterPin: Hashable {
        case characterOne, characterTwo, characterThree, characterFour, characterFive, characterSix
    }
    
    @Environment(\.dismiss) var dismiss
    @State var viewModel: NewUmbrellaViewViewModel
    @FocusState private var pinFocusState: CharacterPin?
    @State var characterOne: String = ""
    @State var characterTwo: String = ""
    @State var characterThree: String = ""
    @State var characterFour: String = ""
    @State var characterFive: String = ""
    @State var characterSix: String = ""
    
    init(username: String) {
        self._viewModel = State(wrappedValue: NewUmbrellaViewViewModel(Username: username))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Text("Join An Umbrella")
                    .font(.custom("Nunito", size: 34))
                    .foregroundStyle(Color.mainBlue)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding()
            
            Text("Enter the six digit group code")
                .font(.custom("Nunito", size: 18))
                .foregroundStyle(Color.mainBlue)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(spacing: 15) {
                
                TextField("", text: $characterOne)
                    .modifier(OtpModifier(pin: $characterOne))
                    .onChange(of:characterOne) {newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .characterTwo
                        }
                    }
                    .focused($pinFocusState, equals: .characterOne)
                
                TextField("", text: $characterTwo)
                    .modifier(OtpModifier(pin: $characterTwo))
                    .onChange(of:characterTwo) {newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .characterThree
                        }
                    }
                    .focused($pinFocusState, equals: .characterTwo)
                
                TextField("", text: $characterThree)
                    .modifier(OtpModifier(pin: $characterThree))
                    .onChange(of:characterThree) {newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .characterFour
                        }
                    }
                    .focused($pinFocusState, equals: .characterThree)
                
                TextField("", text: $characterFour)
                    .modifier(OtpModifier(pin: $characterFour))
                    .onChange(of:characterFour) {newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .characterFive
                        }
                    }
                    .focused($pinFocusState, equals: .characterFour)
                
                TextField("", text: $characterFive)
                    .modifier(OtpModifier(pin: $characterFive))
                    .onChange(of:characterFive) {newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .characterSix
                        }
                    }
                    .focused($pinFocusState, equals: .characterFive)
                
                TextField("", text: $characterSix)
                    .modifier(OtpModifier(pin: $characterSix))
                    .focused($pinFocusState, equals: .characterSix)
            }
            Spacer()
            
            UMButton(title: "Join Group", background: .mainBlue) {
                
                viewModel.joinGroup(GroupId: "\(characterOne)\(characterTwo)\(characterThree)\(characterFour)\(characterFive)\(characterSix)")
            }
            .frame(height: 70)
            .padding()
            
        }.navigationBarBackButtonHidden(true)
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

#Preview {
    JoinAnUmbrella(username: "testadult")
}
