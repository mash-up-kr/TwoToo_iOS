//
//  UITextField+.swift
//  
//
//  Created by Eddy on 2023/06/27.
//

import UIKit

public extension UITextField {
    /// placeholder의 색상을 바꿔주는 메서드
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }

    /// textField에서 글씨를 입력할 때 글자가 입력되는 점의 위치를 조정해주는 메서드
    func addLeftPadding(amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

