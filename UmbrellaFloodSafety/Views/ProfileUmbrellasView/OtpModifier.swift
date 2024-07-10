//
//  OtpModifier.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 1/7/24.
//

import SwiftUI
import Combine

struct OtpModifier: ViewModifier {
    
    @Binding var pin : String
    
    var textLimit = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    
    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimit)}
            .frame(width: 35, height: 45)
            .font(.custom("Nunito", size: 18))
            .foregroundStyle(Color.mainBlue)
            .background(Color.white.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.mainBlue, lineWidth: 6)
            )
    }
}

