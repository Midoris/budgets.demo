//
//  HapticFeedbackManager.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 18.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit
import AudioToolbox

class HapticFeedbackManager {
    
    static let shared = HapticFeedbackManager()
    let selectionFeedback = UISelectionFeedbackGenerator()
    let impactFeeddback = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
    
    private init() {
        selectionFeedback.prepare()
        impactFeeddback.prepare()
    }
    
    func fireHapticSelection() {
        let device = Device()
        if device == .iPhone6s || device == .iPhone6sPlus {
            AudioServicesPlaySystemSoundWithCompletion(1519, nil)
        } else {
            selectionFeedback.selectionChanged()
        }
    }
    
    func fireHapticImpact() {
        let device = Device()
        if device == .iPhone6s || device == .iPhone6sPlus {
            AudioServicesPlaySystemSoundWithCompletion(1519, nil)
        } else {
            impactFeeddback.impactOccurred()
        }
    }
}
