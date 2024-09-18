//
//  BreathingAvatarView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/15/24.
//

import SwiftUI
import Combine

struct BreathingAvatarView: View {
    
    @ObservedObject var viewModel: BreathingViewModel
    
    let profileString: String
    
    var hair: [String] {
        if profilearray[2].contains(";") {
            return profilearray[2].components(separatedBy: ";")
        } else {
            return [profilearray[2]]
        }
    }

    var profilearray: [String] {
        return profileString.components(separatedBy: ",")
        
    }
    
    
    var body: some View {
        if profileString != "" {
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
                Image( viewModel.openEyes ? "openEyes" : "closedEyes")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(x: 1.0, y: viewModel.eyesScale, anchor: UnitPoint(x: 0, y: 0.3))
                
                // blush
                Image(profilearray[4])
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                
                // mouth
                Image( viewModel.openMouth ? "mouth1" : "mouth3")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(viewModel.mouthScale)
                
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
        
    }
}

#Preview {
    BreathingAvatarView(viewModel: BreathingViewModel(), profileString: "skin3,shirt2,gingerback2;gingerfront2,mouth5,blush3,")
}

