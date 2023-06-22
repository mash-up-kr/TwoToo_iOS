//
//  TTPopup.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

public final class TTPopup: UIView, UIComponentBased {

    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        v.spacing = 37
        self.addSubview(v)
        v.addArrangedSubviews(self.titleLabel, self.resultView, self.descriptionLabel, self.buttonStackView)

        return v
    }()

    /// 하단 버튼 2개를 묶어둔 StackView
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
        v.textColor = .grey500
        v.setLineSpacing(15.0)

        return v
    }()

    lazy var leftButton: UIButton = {
        let v = UIButton()
        v.setTitleColor(.grey500, for: .normal)
        v.titleLabel?.font = .omyupretty(size: ._20)

        return v
    }()

    lazy var rightButton: UIButton = {
        let v = UIButton()
        v.setTitleColor(.primary, for: .normal)
        v.titleLabel?.font = .omyupretty(size: ._20)

        return v
    }()

    var buttons = [UIButton]()

    public init (
        title: String,
        resultView: UIView,
        description: String,
        buttons: [UIButton]
    ) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.resultView.addSubview(resultView)
        self.descriptionLabel.text = description
        self.buttons = buttons

        self.attribute()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func attribute() {
        if self.buttons.count == 1 {
            self.leftButton = self.buttons.first ?? UIButton()
            self.rightButton.isHidden = true
        }
        self.leftButton = self.buttons.first ?? UIButton()
        self.rightButton = self.buttons.last ?? UIButton()

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
            make.width.height.equalTo(100)
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
}
