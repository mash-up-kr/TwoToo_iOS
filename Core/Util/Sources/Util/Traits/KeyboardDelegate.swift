//
//  KeyboardDelegate.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import UIKit

public protocol KeyboardDelegate {
    func willShowKeyboard(keyboardFrame: CGRect, duration: Double)
    func willHideKeyboard(duration: Double)
}

public extension KeyboardDelegate where Self: UIViewController {
    func registKeyboardDelegate() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            
            guard let keyboardFrame = notification.keyboardFrame else { return }
            guard let duration = notification.duration else { return }
            
            self?.willShowKeyboard(keyboardFrame: keyboardFrame, duration: duration)
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            
            guard let duration = notification.duration else { return }
            
            self?.willHideKeyboard(duration: duration)
        }
    }
}
