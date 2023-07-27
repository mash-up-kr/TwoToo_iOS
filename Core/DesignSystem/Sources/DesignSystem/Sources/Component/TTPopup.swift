//
//  TTPopup.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

public final class TTPopup: UIView, UIComponentBased {

    /// 팝업 표시시 딤 처리
    lazy var dimView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.5)
        
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.backgroundColor = .mainWhite
        
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        v.spacing = 37
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

    private var buttonTitles: [String] = []

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.attribute()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String,
                          resultView: UIView,
                          description: String,
                          buttonTitles: [String]) {
        self.titleLabel.text = title
        self.resultView.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        self.descriptionLabel.text = description
        self.descriptionLabel.setLineSpacing(8)
        self.buttonTitles = buttonTitles
        self.configureButtons(titles: buttonTitles)
    }
    
    private func configureButtons(titles: [String]) {
        if self.buttonTitles.count == 1 {
            self.leftButton.setTitleColor(.primary, for: .normal)
            self.rightButton.isHidden = true
        }
        else if self.buttonTitles.count > 2 {
            fatalError("Up to 2 buttons can be added")
        }
        
        self.leftButton.setTitle(titles.first, for: .normal)
        self.rightButton.setTitle(titles.last, for: .normal)
    }

    public func layout() {
        self.addSubviews(
            self.dimView,
            self.contentView
        )
        
        self.contentView.addSubviews(
            self.stackView
        )
        
        self.dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(51)
            make.centerY.equalToSuperview()
        }
        
        self.stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(34)
            make.bottom.equalToSuperview().offset(-22)
        }

        self.resultView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }
    }
    
    public func attribute() {
     
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// 배경 눌렀을 때 액션
    @MainActor
    public func didTapBackground(completion: (() -> Void)? = nil) {
        self.dimView.addTapAction {
            completion?()
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
