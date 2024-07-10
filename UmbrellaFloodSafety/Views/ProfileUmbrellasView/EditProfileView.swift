//
//  EditProfileView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    @Binding var isPresented: Bool
    @StateObject var viewModel: EditProfileViewViewModel
    @State private var isSecure: Bool = true
    
    init(isPresented: Binding<Bool>, username: String) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewViewModel())
        UITableView.appearance().backgroundColor = UIColor.clear
        self._isPresented = isPresented
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Edit Profile")
                        .font(.custom("Nunito", size: 34))
                        .fontWeight(.black)
                        .foregroundStyle(Color.mainBlue)
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
                
                
                HStack {
                    Spacer()
                    
                    if StorageManager.shared.ProfileImageURL != "" {
                        AsyncImage(url: URL(string: StorageManager.shared.ProfileImageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 250)
                            } else if phase.error != nil {
                                Image(.umbrellaLogo)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 250)
                                Text("\(String(describing: phase.error?.localizedDescription))")
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    
                    Spacer()
                }.frame(height: 250)
                
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Edit Picture")
                        .bold()
                        .font(.custom("Nunito", size: 24))
                }
                .onChange(of: selectedItem) { oldPhoto, newPhoto in
                    if let newPhoto {
                        Task {
                            guard let data = try await newPhoto.loadTransferable(type: Data.self) else { print("error uploading image")
                                                                                                    return }
                                selectedImageData = data
                                viewModel.uploadImageIntoStorage(data: data)
                            }
                        }
                    }
                if viewModel.uploadStatus != "" {
                    Text("\(viewModel.uploadStatus)")
                }
                
                VStack {
                    HStack {
                        Text("Edit Name")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                            .foregroundStyle(Color.mainBlue)
                        
                        Spacer()
                    }
                    
                    TextField("", text: $viewModel.name, prompt: Text("Edit Name")
                        .foregroundStyle(Color(.darkGray)))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        .font(.custom("Nunito", size: 18))
                }
                .padding([.leading, .trailing], 30)
                
                
                VStack {
                    HStack {
                        Text("Edit Password")
                            .font(.custom("Nunito", size: 24))
                            .bold()
                            .foregroundStyle(Color.mainBlue)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            if isSecure {
                                SecureField("", text: $viewModel.password, prompt: Text("Password")
                                    .foregroundStyle(Color(.darkGray))
                                )
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .font(.custom("Nunito", size: 18))
                            } else {
                                TextField("", text: $viewModel.password, prompt: Text("Edit Password")
                                    .foregroundStyle(Color(.darkGray)))
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .foregroundColor(.black)
                                .font(.custom("Nunito", size: 18))
                            }
                            HStack {
                                
                                Spacer()
                                
                                Button(action: {
                                    isSecure.toggle()
                                }) {
                                    Image(systemName: isSecure ? "eye.slash" : "eye")
                                        .foregroundColor(Color(.darkGray))
                                        .alignmentGuide(.trailing) { d in d[.leading] }
                                }
                                .alignmentGuide(.trailing) { d in d[.leading] }
                                .padding(.trailing, 18)
                            }
                        }
                    }
                }
                .padding([.leading, .trailing, .bottom], 30)
                
                UMButton(title: "Save Changes", background: .mainBlue) {
                    viewModel.saveChanges()
                }
                .padding([.leading, .trailing], 30)
                .frame(height: 70)
                
                Spacer()
            }
        }
    }
}

#Preview {
    struct EditProfileViewContainer: View {
        @State private var isPresented = false
        
        var body: some View {
            EditProfileView(isPresented: $isPresented, username: "testadult")
        }
    }
    
    return EditProfileViewContainer()
}
