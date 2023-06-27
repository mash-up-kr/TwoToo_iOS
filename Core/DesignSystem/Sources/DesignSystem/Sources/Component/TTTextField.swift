//

//  TTTextField.swift
//  
//
//  Created by Eddy on 2023/06/20.
//

import UIKit
import Util

final public class TTTextField: UIView, UIComponentBased {
    /// TextField 최대 글자수
    var maxLength = 0
    /// return 버튼 눌렀을 때의 completion
    /// 사용법
    /// ```swift
    ///    textfield.returnValueAction = { text in
    ///    print(text) }
    /// ```
    
    public var returnValueAction: ((String) -> Void)?
    /// 값이 변했을 때 접근하는 completion
    /// 사용법
    /// ```swift
    ///    textfield.didChangeTextAction = { text in
    ///    print(text) }
    /// ```
    public var didChangeTextAction: ((String) -> Void)?

    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .primary

        return v
    }()

    lazy var textField: UITextField = {
        let v = UITextField()
        v.font = .body1
        v.textColor = .primary
        v.backgroundColor = .mainWhite
        v.placeholder = "기본"
        v.setPlaceholder(color: .grey500)
        v.layer.cornerRadius = 10
        v.addLeftPadding(amount: 10)
        v.delegate = self

        return v
    }()

    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 8

        return v
    }()

    /// title명, placeholder, maxLength 지정
    public init(
        title: String,
        placeholder: String,
        maxLength: Int
    ) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        self.maxLength = maxLength
        self.attribute()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func attribute() {
        self.textField.addTarget(self, action: #selector(self.didChangeTextfieldText), for: .editingChanged)

        self.stackView.addArrangedSubviews(self.titleLabel, self.textField)
        self.addSubview(self.stackView)
    }

    public func layout() {
        self.stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.textField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.size.height * 0.054)
        }
    }
    
    /// textField의 값을 가져오는 함수
    public func getTextFieldValue() -> String {
        return textField.text ?? ""
    }

    @objc private func didChangeTextfieldText(_ notification: Notification) {
        if let text = self.textField.text {
            /// 초과되는 텍스트 입력 못하도록 한다
            if text.count >= self.maxLength {
                let index = text.index(text.startIndex, offsetBy: self.maxLength)
                let newString = text[text.startIndex..<index]
                self.textField.text = String(newString)
            }
            self.didChangeTextAction?(self.textField.text ?? "")
        }
    }
}

extension TTTextField: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.returnValueAction?(textField.text ?? "")
        return true
    }
}
