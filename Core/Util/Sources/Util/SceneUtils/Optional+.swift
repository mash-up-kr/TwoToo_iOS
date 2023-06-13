//
//  Optional+.swift
//  
//
//  Created by Eddy on 2023/06/09.
//

import Foundation

/*
 옵셔널을 제거하고 이어지는 행동을 작성한다.

 title.unwrap { value in
     print(value)
 }

*/
public extension Optional {
    func unwrap(_ completion: @escaping (Wrapped) -> Void) {
        if let unwrappedValue = self {
            completion(unwrappedValue)
        }
    }
}
