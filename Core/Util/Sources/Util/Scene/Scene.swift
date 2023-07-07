//
//  Scene.swift
//  
//
//  Created by 박건우 on 2023/06/04.
//

import UIKit

public protocol Scene {
    
    var viewController: UIViewController { get }
}

public extension Scene where Self: UIViewController {
    
    var viewController: UIViewController {
        return self
    }
}
