//
//  UIView+.swift
//  
//
//  Created by Eddy on 2023/06/08.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for v in views {
            self.addSubview(v)
        }
    }
    func addTapAction(_ closure: @escaping Closure) {
        let sleeve = ClosureSleeve(closure)
        self.addGestureRecognizer(
            UITapGestureRecognizer(target: sleeve, action: #selector(ClosureSleeve.invoke))
        )
        objc_setAssociatedObject(
            self,
            String(format: "[%d]", arc4random()),
            sleeve,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
    
    /// 종이재질 배경색 적용
    /// 사용 예시:
    /// self.view.setBackgroundDefault()
    func setBackgroundDefault() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "home_background", in: Bundle.module, with: nil)!)
    }
}
