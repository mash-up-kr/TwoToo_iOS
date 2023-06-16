//
//  UIImageView+.swift
//  
//
//  Created by Julia on 2023/06/16.
//

import UIKit

extension UIImageView {
    
    /// DesignSystem Image를 ImageView에 설정합니다.
    ///
    /// 사용예시
    /// ```swift
    /// UIImageView(.icon_bee)
    /// ```
    public convenience init(_ asset: Assets) {
        self.init(image: asset.image)
    }
    
}
