//
//  KidsEmergencyGuide.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 17/7/24.
//

import SwiftUI

struct KidsEmergencyGuide: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var tabController: TabController
    @State var isPresented = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text(LocalizedStringKey("What do I do in a Flood?"))
                    .font(.custom("Nunito", size: 32))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            .padding([.leading, .top])
            
            HStack {
                Text(LocalizedStringKey("For kids"))
                    .font(.custom("Nunito", size: 24))
                    .bold()
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            .padding(.leading)
            
            NavigationStack {
                ScrollView {
                    
                    HStack {
                        Text(LocalizedStringKey("1. Remember your emergency plan (if you have one)"))
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Spacer()
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "doc.text")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.mainBlue)
                                .padding(13)
                            
                            Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.accentGreen)
                                .frame(width: 60)
                                .padding(.bottom, -25)
                                .padding(.trailing, -25)
                        }
                        .frame(width: 100)
                        .padding()
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("2. Stay away from \nthe flood water"))
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Spacer()
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "water.waves")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.mainBlue)
                            
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.accentYellow)
                                .frame(width: 60)
                                .background(Rectangle().frame(width: 15, height: 40).foregroundStyle(.red))
                                .padding(.bottom, -25)
                                .padding(.trailing, -25)
                        }
                        .frame(width: 100)
                        .padding()
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("3. Find a trusted \nadult"))
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Spacer()
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "figure.and.child.holdinghands")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.mainBlue)
                            
                            Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.accentGreen)
                                .frame(width: 60)
                                .padding(.bottom, -25)
                                .padding(.trailing, -25)
                        }
                        .frame(width: 100)
                        
                        
                    }
                    .padding(.trailing, 30)
                    
                    HStack {
                        Text(LocalizedStringKey("4. If you still feel unsafe or there are no adults, call 911"))
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Spacer()
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "phone.badge.waveform.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.mainBlue)
                            
                            
                            Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.accentGreen)
                                .frame(width: 60)
                                .padding(.bottom, -25)
                                .padding(.trailing, -25)
                        }
                        .frame(width: 100)
                        .padding([.top, .horizontal])
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        Call911Button()
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(LocalizedStringKey("5. Call or text trusted adults"))
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Spacer()
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "figure.2.and.child.holdinghands")
                                .resizable()
                                .scaledToFit()
                                .padding(.trailing, 4.5)
                                .foregroundStyle(.mainBlue)
                            
                            Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.accentGreen)
                                .frame(width: 60)
                                .padding(.bottom, -25)
                                .padding(.trailing, -25)
                        }
                        .frame(width: 100)
                        .padding(.horizontal, 30)
                        
                    }
                    
                    NavigationLink(destination: MessagingView()) {
                        
                        Button {
                            tabController.open(.messages)
                        } label: {
                            HStack {
                                
                                Image(systemName: "message.fill")
                                    .foregroundStyle(.white)
                                
                                Text(LocalizedStringKey("Text through Umbrella"))
                                    .font(.custom("Nunito", size: 18))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 15)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 30).foregroundStyle(.mainBlue))
                            
                            Spacer()
                        }
                    }
                    .padding(.bottom)
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text(LocalizedStringKey("Sources"))
                            .font(.custom("Nunito", size: 18))
                            .foregroundStyle(.mainBlue)
                    }
                }
                .padding(.leading)
                .sheet(isPresented: $isPresented, content: {
                    
                    HStack {
                        Text(LocalizedStringKey("Flood Safety Sources"))
                            .font(.custom("Nunito", size: 32))
                            .foregroundStyle(.mainBlue)
                            .bold()
                        
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
                    
                    FloodSafetyResources()
                        .padding(.leading)
                })
            }
            
            
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
        }
    }
}

#Preview {
    KidsEmergencyGuide()
}
