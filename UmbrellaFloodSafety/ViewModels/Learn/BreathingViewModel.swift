//
//  BreathingViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/14/24.
//

import CoreHaptics
import Foundation
import SwiftUI

class BreathingViewModel: ObservableObject {
    
    @Published var openEyes: Bool = true
    @Published var openMouth: Bool = true
    @Published var eyesScale: CGFloat = 1.0
    @Published var mouthScale: CGFloat = 1.0
    @Published var playing: Bool = false
    @Published var gradientColors: Bool = true
    @Published var stage: String = "Click the play button to begin"
    
    private var hapticEngine: CHHapticEngine?
    
    init() {
        initHaptics()
    }
    
    func initHaptics() {
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic engine could not start, proceeding w/out it")
        }
    }
    
    func breathCycle() {
        
        // close eyes
        withAnimation(.easeIn(duration: 0.2)) {
            eyesScale = 0.0
            self.stage = "Get ready..."
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.openEyes.toggle()
            withAnimation(.easeOut(duration: 0.3)) {
                self.eyesScale = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.breath()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 11.6) {
            self.breath()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 23) {
            self.breath()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 34.5) {
            if self.openMouth == false {
                withAnimation(.easeIn(duration: 0.2)) {
                    self.mouthScale = 0.0
                }
                
                // close mouuth
                
                self.openMouth.toggle()
                withAnimation(.easeOut(duration: 0.5)) {
                    self.mouthScale = 1
                }
            }
            
            // open eyes
            
            withAnimation(.easeIn(duration: 0.2)) {
                self.eyesScale = 0.0
                self.stage = "All done!"
            }
            
            self.openEyes.toggle()
            withAnimation(.easeOut(duration: 0.3)) {
                self.eyesScale = 1
            }
            
            self.playing = false
        }
        
    }
    
    private func breath() {
        
        guard playing else {
            withAnimation(.easeIn(duration: 0.2)) {
                self.stage = "Click the play button to begin"
            }
            return
        }
        // breathe in
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.playHaptic(for: .breatheIn)
            // turn gradient on
            withAnimation(.easeIn(duration: 0.5)) {
                self.gradientColors.toggle()
                self.stage = "Breathe in..."
            }
        }
        
        // hold breath for 3 seconds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.playHaptic(for: .holdBreath)
            
            withAnimation(.easeIn(duration: 0.2)) {
                self.stage = "Hold your breath..."
            }
            
        }
        
        // breathe out
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.playHaptic(for: .breatheOut)
            withAnimation(.easeIn(duration: 0.2)) {
                self.stage = "Slowly breathe out..."
            }
            self.breatheOut()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.5) {
            self.breatheOutNoGradient()
        }
        
    }
    
    private func breatheOut() {
        
        withAnimation(.easeIn(duration: 0.2)) {
            mouthScale = 0.0
        }
        
        //open mouth
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.openMouth.toggle()
            withAnimation(.easeOut(duration: 0.5)) {
                self.gradientColors.toggle()
                self.mouthScale = 1
            }
        }
    }
    private func breatheOutNoGradient() {
        
        withAnimation(.easeIn(duration: 0.2)) {
            mouthScale = 0.0
        }
        
        //open mouth
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.openMouth.toggle()
            withAnimation(.easeOut(duration: 0.5)) {
                self.mouthScale = 1
            }
        }
    }
    
    private func playHaptic(for type: hapticType) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        // set up events
        
        var events = [CHHapticEvent]()
        
        switch type {
        case .breatheIn:
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 2.5)
            events.append(event)
        case .holdBreath:
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 3)
            events.append(event)
        case .breatheOut:
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 4)
            events.append(event)
        }
        
        // play
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Haptic engine is in its flop era", error.localizedDescription)
        }
    }
    
}

enum hapticType {
    case breatheIn
    case holdBreath
    case breatheOut
}
