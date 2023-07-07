//
//  UIWindow+.swift
//  
//
//  Created by 박건우 on 2023/06/14.
//

import UIKit

public extension UIWindow {
    
    /// 가장 상위의 `UIWindow`를 반환합니다.
    /// 찾지 못하였을 경우 `nil`을 반환합니다.
    static var key: UIWindow? {
        if #available(iOS 15, *) {
            return UIApplication.shared.connectedScenes
                // Keep only active scenes, onscreen and visible to the user
                .filter { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
                // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
                // Get its associated windows
                .flatMap({ $0 as? UIWindowScene })?.windows
                // Finally, keep only the key window
                .first(where: \.isKeyWindow)
        }
        else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
}
