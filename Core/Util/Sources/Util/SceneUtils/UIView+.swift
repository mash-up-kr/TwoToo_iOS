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
}
