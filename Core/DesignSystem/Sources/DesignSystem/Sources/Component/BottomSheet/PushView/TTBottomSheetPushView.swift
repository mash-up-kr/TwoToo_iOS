//
//  TTBottomSheetPushView.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import UIKit

public final class TTBottomSheetPushView: UIScrollView {
    
    private var maxHeight: CGFloat
    
    private let containerLeadingTrailingInset: CGFloat = 24
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textColor = .primary
        return v
    }()
    
    private lazy var messageTextField: UITextField = {
        let v = UITextField()
        v.font = .body1
        v.textColor = .primary
        v.backgroundColor = .mainWhite
        return v
    }()
    
    // TODO: 컴포넌트 버튼으로 변경필요
    private lazy var pushButton: UIButton = {
        let v = UIButton()
        v.setTitle("보내기", for: .normal)
        return v
    }()
    
    public init(maxHeight: CGFloat,
                title: String,
                placeHolder: String) {
        self.maxHeight = maxHeight
        super.init(frame: .zero)
        self.layout()
        self.titleLabel.text = title
        self.messageTextField.placeholder = placeHolder
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.titleLabel, self.messageTextField, self.pushButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerY.equalToSuperview()
        }
        
        self.messageTextField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.trailing.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.height.equalTo(85)
        }
        
        self.pushButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.trailing.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.bottom.equalToSuperview().inset(14)
            make.height.equalTo(57)
        }
    }
}
