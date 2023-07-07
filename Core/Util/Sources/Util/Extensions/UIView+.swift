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
}
