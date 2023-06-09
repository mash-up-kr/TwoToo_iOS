//
//  File.swift
//  
//
//  Created by Eddy on 2023/06/08.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for v in views {
            self.addArrangedSubview(v)
        }
    }
}
