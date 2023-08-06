//
//  TransitionOptions.swift
//  
//
//  Created by 박건우 on 2023/07/24.
//

import Foundation
import UIKit

public struct TransitionOptions {
    // Transition Options
    public var direction: TransitionOptions.Direction     = .toRight
    public var style: TransitionOptions.Curve             = .linear
    public var background: TransitionOptions.Background?  = nil
    public var duration: TransitionOptions.Duration       = .main
    
    public var animation: CATransition {
        let transition            = self.direction.transition()
        transition.duration       = self.duration.rawValue
        transition.timingFunction = self.style.function
        return transition
    }
    
    public init(direction: Direction = .toRight, style: Curve = .linear, duration: Duration = .main) {
        self.direction = direction
        self.style     = style
        self.duration  = duration
    }
    
    public enum Curve {
        case linear
        case easeIn
        case easeOut
        case easeInOut
        
        var function: CAMediaTimingFunction {
            let key: String!
            switch self {
            case .linear:        key = CAMediaTimingFunctionName.linear.rawValue
            case .easeIn:        key = CAMediaTimingFunctionName.easeIn.rawValue
            case .easeOut:        key = CAMediaTimingFunctionName.easeOut.rawValue
            case .easeInOut:    key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
            }
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key!))
        }
    }
    
    // Direction of the animation
    public enum Direction {
       case fade
       case toTop
       case toBottom
       case toLeft
       case toRight
       
       /// Return the associated transition
       ///
       /// - Returns: transition
       public func transition() -> CATransition {
           let transition = CATransition()
           transition.type = CATransitionType.push
           switch self {
           case .fade:
               transition.type = CATransitionType.fade
               transition.subtype = nil

           case .toLeft:
               transition.subtype = CATransitionSubtype.fromLeft

           case .toRight:
               transition.subtype = CATransitionSubtype.fromRight

           case .toTop:
               transition.subtype = CATransitionSubtype.fromTop

           case .toBottom:
               transition.subtype = CATransitionSubtype.fromBottom
           }
           return transition
       }
   }
    
    public enum Background {
        case solidColor(_: UIColor)
        case customView(_: UIView)
    }
    
    public enum Duration: TimeInterval {
        case main = 0.3
    }
    
}
