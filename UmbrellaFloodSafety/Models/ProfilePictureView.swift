//
//  ProfilePictureView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 12/7/24.
//

import SwiftUI
import Combine

struct ProfilePictureView: View {
    
    
    init(profileString: String) {
        
        self.profilestring = profileString
        
    }
    
    
    let profilestring: String
    
    var hair: [String] {
        if profilearray[2].contains(";") {
            return profilearray[2].components(separatedBy: ";")
        } else {
            return [profilearray[2]]
        }
    }

    var profilearray: [String] {
        return profilestring.components(separatedBy: ",")
        
    }
    
    
    var body: some View {
        if profilestring != "" {
            ZStack {
                // back of hair
                
                if hair.count == 2 {
                    Image(hair[0])
                        .resizable()
                        .scaledToFit()
                }
                // skin
                Image(profilearray[0])
                    .resizable()
                    .scaledToFit()
                
                //eyes
                Image("openEyes")
                    .resizable()
                    .scaledToFit()
                
                // blush
                Image(profilearray[4])
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                
                // mouth
                Image(profilearray[3])
                    .resizable()
                    .scaledToFit()
                
                Image(profilearray[5])
                    .resizable()
                    .scaledToFit()
                
                if hair.count == 2 {
                    Image(hair[1])
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(hair[0])
                        .resizable()
                        .scaledToFit()
                }
                
                Image(profilearray[1])
                    .resizable()
                    .scaledToFit()
                
            }
        }
        
        if profilestring == "" {
            Circle()
        }
    }
}

#Preview {
    ProfilePictureView(profileString: "skin3,shirt2,gingerback2;gingerfront2,mouth5,blush3,")
}
