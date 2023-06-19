//
//  Popup.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

public class Popup: UIView, UIComponentBased {

    override public init(frame: CGRect) {
        super.init(frame: .zero)

        self.attribute()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func layout() { }
    public func attribute() { }
}

extension Popup {
    public enum PopType {
        case allCommit
        case quitChallenge
        case success
        case finish
    }

     /// allCommit: 모두 인증 완료 시 띄어주는 팝업
     /// quitChallenge: 챌린지 그만두기 시 띄어주는 팝업
     /// success: 챌린지 달성률 둘다 성공했을 때 띄어주는 팝업
     /// finish: 챌린지 다성률 둘다 성공하지 않고 끝났을 때 띄어주는 팝업

     /// 사용 예시:
     ///    ```swift
     ///       TTPopup.create(.allCommit)
     ///    ```

    public static func create(_ type: PopType) -> PopupView {
        switch type {
        case .allCommit:
            return PopupView(customePopupType: .allCommit)

        case .quitChallenge:
            return PopupView(customePopupType: .quitChallenge)

        case .success:
            return PopupView(customePopupType: .success)
            
        case .finish:
            return PopupView(customePopupType: .finish)
        }
    }
}
