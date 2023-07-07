//
//  Notification+.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import UIKit

public extension Notification {
    /// get key board frame when willAppear
    var keyboardFrame: CGRect? {
        var rect: CGRect? = nil
        if let userInfo = self.userInfo,
           let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            rect = frame.cgRectValue
        }
        
        return rect
    }
    /// get key board appear duration
    var duration: Double? {
        var dur: Double? = nil
        if let userInfo = self.userInfo,
           let value = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            dur = value
        }
        
        return dur
    }
}
