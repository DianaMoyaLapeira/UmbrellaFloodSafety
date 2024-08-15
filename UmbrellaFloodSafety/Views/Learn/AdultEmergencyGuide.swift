//
//  AdultEmergencyGuide.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 17/7/24.
//

import SwiftUI

struct AdultEmergencyGuide: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var tabController: TabController
    @State var isPresented: Bool = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text("What do I do in a Flood?")
                    .font(.custom("Nunito", size: 32))
                    .fontWeight(.black)
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            .padding([.leading, .top])
            
            HStack {
                Text("For Adults")
                    .font(.custom("Nunito", size: 24))
                    .bold()
                    .foregroundStyle(.mainBlue)
                
                Spacer()
            }
            .padding(.leading)
            
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
                
                if EmergencyPlanFirebaseManager.shared.emergencyPlans.count > 0 {
                    NavigationLink(destination: EmergencyPlans()) {
                        Text("Go to emergency plans on Umbrella")
                            .font(.custom("Nunito", size: 18))
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).fill(.mainBlue))
                    }
                    .padding(.bottom)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("2. Stay away from \nthe flood water"))
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("Remember: Turn around, don't drown!")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
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
                .padding(.bottom)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("3. Get to high ground")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("Stay on high ground if you're already there.")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "mountain.2")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.mainBlue)
                        
                        Image(systemName: "arrowshape.up.fill")
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
                    VStack(alignment: .leading) {
                        Text("3. Stay informed")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("Check for updates through official weather broadcasts using the Internet, radio, television, etc.")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .foregroundStyle(.mainBlue)
                        
                        Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.accentGreen)
                            .frame(width: 60)
                            .padding(.bottom, -20)
                            .padding(.trailing, -40)
                    }
                    .frame(width: 100)
                    .padding()
                    
                    Spacer()
                    
                }
                .padding(.vertical)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("4. Obey evacuation orders")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("Evacuate immediately if ordered to do so. Lock doors and disconnect utilities/appliances if you have time.")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "figure.run")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
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
                    .padding()
                    
                    Spacer()
                    
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("5. Electrical Safety")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("Avoid rooms with submerged electrical outlets. Get away from any sparks, hissing, or cracking noises.")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "bolt")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
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
                    VStack(alignment: .leading) {
                        Text("5. Call 911 if you feel unsafe")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("You can also report downed power lines or gas leaks through 911.")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "phone.badge.waveform")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.mainBlue)
                        
                        
                        Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.accentGreen)
                            .frame(width: 60)
                            .padding(.bottom, -25)
                            .padding(.trailing, -35)
                    }
                    .frame(width: 100)
                    .padding([.top, .horizontal])
                    
                    Spacer()
                    
                }
                .padding(.vertical)
                
                HStack {
                    Call911Button()
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("6. Check in on loved ones")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                        
                        Text("Make sure your loved ones are safe.")
                            .font(.custom("Nunito", size: 18 ))
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "person.2")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.mainBlue)
                        
                        
                        Image(systemName: "heart.fill")
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
                .padding(.vertical)
                
                if !FirebaseManager.shared.conversations.isEmpty {
                    UMButton(title: "Text through Umbrella", background: .mainBlue) {
                        tabController.open(.messages)
                    }
                    .frame(height: 60)
                }
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text(LocalizedStringKey("Sources"))
                        .font(.custom("Nunito", size: 18))
                        .foregroundStyle(.mainBlue)
                }
                
            }
            .padding(.horizontal)
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
    AdultEmergencyGuide()
}
