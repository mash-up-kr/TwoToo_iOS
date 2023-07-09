//
//  UIDevice+.swift
//  
//
//  Created by 박건우 on 2023/07/06.
//

import UIKit

public extension UIDevice {

    var safeAreaTopHeight: CGFloat {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.top ?? 0
    }

    var safeAreaBottomHeight: CGFloat {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
    }
    
    var isPlusSize: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
            && (UIScreen.main.bounds.size.width >= 414 || self.hasNotch) {
            return true
        }
        return false
    }
    
    var hasNotch: Bool {
        let bottom = UIWindow.key?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    var deviceType: DeviceTypes {
        let deviceName = UIDevice.current.name.lowercased()
        
        if deviceName.contains("max") {
            return .max
        }
        else {
            return self.hasNotch ? .standard : .default
        }
    }
    
    enum DeviceTypes {
        case `default` // (7/8/SE)
        case standard // (X/11 pro/12 mini/13 mini)")
        case max
    }
    
}
