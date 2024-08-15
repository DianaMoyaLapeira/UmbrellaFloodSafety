//
//  Settings.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/7/24.
//

import SwiftUI
import CoreLocation

struct Settings: View {
    
    @State var showSheet: Bool = false
    @State var showAlert: Bool = false
    @StateObject var viewModel = SettingsViewModel()
    @State var recoveryEmail = ""
    @Binding var isPresented: Bool
    @State private var locationSharing: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        locationSharing = CLLocationManager.locationServicesEnabled()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Settings")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(.mainBlue)
                    
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
                
                HStack {
                    Text("Location sharing")
                        .font(.custom("Nunito", size: 18))
                    
                    Spacer()
                    
                    Toggle("", isOn: $locationSharing)
                }
                .onChange(of: locationSharing) {
                    if locationSharing {
                        viewModel.LocationOff()
                    } else {
                        viewModel.LocationOn()
                    }
                }
                
                NavigationLink {
                    UnblockUsers()
                } label: {
                    Text("Unblock Users")
                        .font(.custom("Nunito", size: 18))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.primary)
                .padding(.top)
                
                UMButton(title: "Set up Recovery Email", background: .mainBlue) {
                    showSheet.toggle()
                }
                .frame(height: 60)
                .padding(.vertical)
                
                UMButton(title: "Delete account", background: .red) {
                    showAlert.toggle()
                }
                .frame(height: 60)
                
                Spacer()
                
                Text("Contact Umbrella Flood Safety through \ncontact@umbrellafloodsafety.com")
                    .font(.custom("Nunito", size: 18))
                    .multilineTextAlignment(.center)
                    
            }
            .padding()
            .alert("Delete Account?", isPresented: $showAlert) {
                Button("Delete Account", role: .destructive) {
                    viewModel.deleteAccount()
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showSheet, content: {
                VStack {
                    HStack {
                        Text("Set Up Recovery Email")
                            .font(.custom("Nunito", size: 34))
                            .fontWeight(.black)
                            .foregroundStyle(.mainBlue)
                            .multilineTextAlignment(.leading)
                
                        Spacer()
                        
                        VStack {
                            Button {
                                showSheet.toggle()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34)
                            }
                            .padding(.top)
                            
                            Spacer()
                        }
                    }
                    .frame(height: 100)
                    .padding()
                    
                    HStack {
                        Text("Enter recovery email here: ")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    TextField("", text: $recoveryEmail, prompt: Text("Recovery Email")
                        .foregroundStyle(Color(.darkGray)))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(25)
                        .foregroundColor(.black)
                        .font(.custom("Nunito", size: 18))
                        .padding()
                    
                    UMButton(title: "Submit", background: .mainBlue) {
                        viewModel.inputEmail(email: recoveryEmail)
                        showSheet.toggle()
                    }
                    .padding(.horizontal)
                    .frame(height: 60)
                    
                    Spacer()
                }
                .padding()
                
        })
        }
    }
}

#Preview {
    struct SettingsContainer: View {
        @State private var isPresented = false
        
        var body: some View {
            Settings(isPresented: $isPresented)
        }
    }
    
    return SettingsContainer()
}

