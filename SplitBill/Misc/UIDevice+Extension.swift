//
//  UIDevice+Extension.swift
//  SplitBill
//
//  Created by Clive Liu on 12/9/20.
//

import UIKit
import AudioToolbox


extension UIDevice {
    
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
