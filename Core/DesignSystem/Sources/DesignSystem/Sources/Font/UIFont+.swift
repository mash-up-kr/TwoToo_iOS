//
//  UIFont+.swift
//  
//
//  Created by Julia on 2023/06/10.
//

import UIKit

extension UIFont {
    
    /// fontSize : 28
    public static var h1: UIFont {
        return .omyupretty(size: ._28)
    }
    /// fontSize : 24
    public static var h2: UIFont {
        return .omyupretty(size: ._24)
    }
    /// fontSize : 20
    public static var h3: UIFont {
        return .omyupretty(size: ._20)
    }
    /// fontSize : 18
    public static var h4: UIFont {
        return .omyupretty(size: ._18)
    }
    /// fontSize : 16
    public static var body1: UIFont {
        return .omyupretty(size: ._16)
    }
    /// fontSize : 15
    public static var body2: UIFont {
        return .omyupretty(size: ._15)
    }
    /// fontSize : 12
    public static var body3: UIFont {
        return .omyupretty(size: ._12)
    }
}

extension UIFont {
    
    /// OmyuPretty 폰트 적용
    /// - Parameters:
    ///  - ofSize: 등록할 폰트 크기
    public static func omyupretty(size: Font.Size) -> UIFont {
        let font = Font.TTFont()
        return ._font(name: font.name, size: size.rawValue)
    }
    
    public static func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
