//
//  PopupView.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

public class PopupView: UIView, UIComponentBased {

    var customPopupType: PopupViewType = .allCommit

    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        v.spacing = 37
        self.addSubview(v)
        v.addArrangedSubviews(self.titleLabel, self.resultView, self.descriptionLabel, self.buttonStackView)

        return v
    }()

    lazy var buttonStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.addArrangedSubviews(self.leftButton, self.rightButton)
        v.alignment = .center
        v.spacing = 73

        return v
    }()

    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.text = self.customPopupType.title
        v.textColor = .primary

        return v
    }()

    /// 팝업 상태에 따라 보여주는 UIView
    lazy var resultView: UIView = {
        let v = UIView()

        return v
    }()

    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.font = .omyupretty(size: ._16)
        v.numberOfLines = 0
        v.textAlignment = .center
        v.text = self.customPopupType.description
        v.textColor = .grey500
        v.setLineSpacing(15.0)

        return v
    }()

    lazy var leftButton: UIButton = {
        let v = UIButton()
        v.setTitleColor(.grey500, for: .normal)
        v.titleLabel?.font = .omyupretty(size: ._20)
        v.setTitle(self.customPopupType.leftButtonTitle, for: .normal)
        v.isHidden = self.customPopupType.isLeftButtonHidden

        return v
    }()

    lazy var rightButton: UIButton = {
        let v = UIButton()
        v.setTitleColor(.primary, for: .normal)
        v.titleLabel?.font = .omyupretty(size: ._20)
        v.setTitle(self.customPopupType.rightButtonTitle, for: .normal)

        return v
    }()

    convenience init(customePopupType: PopupViewType) {
        self.init(frame: .zero)
        self.customPopupType = customePopupType

        self.attribute()
        self.layout()
    }

    public func attribute() {
        self.layer.cornerRadius = 20
        self.backgroundColor = .mainWhite
    }

    public func layout() {
        self.stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(34)
            make.bottom.equalToSuperview().offset(-22)
        }

        self.resultView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(180)
        }
    }

     /// 왼쪽 버튼 눌렀을 때 액션 넣는 법
     /// leftButton.didTapLeftButton {
     ///     print("leftButton tapped")
     /// }
    @MainActor
    public func didTapLeftButton(completion: (() -> Void)? = nil) {
        self.leftButton.addAction {
            completion?()
        }
    }

    /// 오른쪽 버튼 눌렀을 때 액션 넣는 법
    /// rightButton.didTapRightButton {
    ///     print("rightButton tapped")
    /// }
    @MainActor
    public func didTapRightButton(completion: (() -> Void)? = nil) {
        self.rightButton.addAction {
            completion?()
        }
    }

    /// 챌린지 상태에 따라 띄어주는 팝업에 보여지는 UIView를 넣는 함수
    public func setResultView(_ view: UIView) {
        self.resultView.addSubview(view)
    }
}

extension PopupView {
    public enum PopupViewType {
        case allCommit
        case quitChallenge
        case success
        case finish

        var title: String? {
            switch self {
            case .allCommit:
                return "모두 인증 완료"

            case .quitChallenge:
                return "챌린지 그만두기"

            case .success:
                return "축하합니다!"

            case .finish:
                return "수고했어요!"
            }
        }

        var description: String? {
            switch self {
            case .allCommit:
                return "서로 인증을 완료했어요!\n짝꿍에게 응원 한마디를 남겨요"

            case .quitChallenge:
                return "기존의 챌린지는 삭제 됩니다\n*그만두기 시 양쪽 모두에게\n삭제 및 종료됩니다!*"

            case .success:
                return "둘다 꽃을 피웠어요!\n서로의 꽃을 확인해보세요!"

            case .finish:
                return "챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"
            }
        }

        var leftButtonTitle: String? {
            switch self {
            case .allCommit:
                return "괜찮아요"

            case .quitChallenge:
                return "취소"

            case .success:
                return ""

            case .finish:
                return ""
            }
        }

        var isLeftButtonHidden: Bool {
            switch self {
            case .allCommit:
                return false

            case .quitChallenge:
                return false

            case .success:
                return true

            case .finish:
                return true
            }
        }

        var rightButtonTitle: String? {
            switch self {
            case .allCommit:
                return "칭찬하기"

            case .quitChallenge:
                return "그만두기"

            case .success:
                return "확인"

            case .finish:
                return "확인"
            }
        }
    }
}
