//
//  addAction+.swift
//  
//
//  Created by Eddy on 2023/06/09.
//

import UIKit


/*
 button.addAction {
     print("action")
 }

 view.addTapAction {
     print("Tap")
 }
 */

public extension UIControl {
    func addAction(
        for controlEvents: UIControl.Event = .touchUpInside,
        _ closure: @escaping Closure
    ) {
        let sleeve = ClosureSleeve(closure)
        self.addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(
            self,
            String(format: "[%d]", arc4random()),
            sleeve,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
}
