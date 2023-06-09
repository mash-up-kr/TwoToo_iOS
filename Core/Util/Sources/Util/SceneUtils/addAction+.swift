//
//  File.swift
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


class ClosureSleeve {
    let closure: Closure

    init(_ closure: @escaping Closure) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}

public typealias Closure = () -> Void

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

public extension UIView {

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
