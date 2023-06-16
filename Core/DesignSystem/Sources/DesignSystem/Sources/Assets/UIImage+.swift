//
//  UIImage+.swift
//  
//
//  Created by Julia on 2023/06/16.
//

import UIKit

extension UIImage {
    
    /// DesignSystem Image를 설정합니다.
    ///
    /// 사용예시
    /// ```swift
    /// UIImage.asset(.icon_bee)
    /// ```
    public static func asset(_ _asset: Assets) -> UIImage? {
        return _asset.image
    }
    
}
