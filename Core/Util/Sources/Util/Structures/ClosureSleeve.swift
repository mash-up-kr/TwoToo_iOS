//
//  ClosureSleeve.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public typealias Closure = () -> Void

class ClosureSleeve {
    let closure: Closure

    init(_ closure: @escaping Closure) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}

