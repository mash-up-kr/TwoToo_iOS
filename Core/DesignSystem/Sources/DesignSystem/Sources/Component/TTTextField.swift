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

        return v
    }()

    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 8

        return v
    }()

    public init(title: String, placeholder: String, maxLength: Int) {
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
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeTextfieldText), name: UITextField.textDidChangeNotification, object: self.textField)
        self.stackView.addArrangedSubviews(self.titleLabel, self.textField)
        self.addSubview(self.stackView)
    }

    public func layout() {
        self.stackView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.size.width - 48)
        }

        self.textField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.size.height * 0.05)
        }
    }

    @objc private func didChangeTextfieldText(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                /// 초과되는 텍스트 입력 못하도록 한다
                if text.count >= self.maxLength {
                    let index = text.index(text.startIndex, offsetBy: self.maxLength)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
            }
        }
    }
}
