//
//  UILabel+.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit

public extension UILabel {
    /*
     사용법:
        ```swift
            label.setLineSpacing(15.0)

        ```
     */
    /// 각 line마다 spacing 만드는 함수
    func setLineSpacing(_ spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
