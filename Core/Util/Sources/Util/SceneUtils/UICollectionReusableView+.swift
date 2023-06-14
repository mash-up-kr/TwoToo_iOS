//
//  UICollectionReusableView+.swift
//  
//
//  Created by Eddy on 2023/06/08.
//

import UIKit

public extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
