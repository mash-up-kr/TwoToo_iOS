//
//  TTBottomSheetCommitView.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import UIKit

final public class TTBottomSheetCommitView: UIScrollView {
    
    private var maxHeight: CGFloat
    
    private let containerLeadingTrailingInset: CGFloat = 24

    
    override public var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width,
               height: min(contentSize.height, maxHeight))
    }
    
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "인증하기"
        v.font = .h2
        v.textColor = .primary
        return v
    }()
    
    private lazy var commitPhotoView: TTBottomSheetCommitPhotoView = {
        let v = TTBottomSheetCommitPhotoView(frame: .zero) // 수정 필요
        return v
    }()
    
    private lazy var commentTextField: UITextField = {
        let v = UITextField()
        v.placeholder = "소감을 작성해 주세요."
        v.font = .body1
        v.textColor = .grey500
        v.backgroundColor = .mainWhite
        return v
    }()
    
    // TODO: 컴포넌트 버튼으로 변경필요
    private lazy var commitButton: UIButton = {
        let v = UIButton()
        v.setTitle("인증 하기", for: .normal)
        return v
    }()
    
    public init(maxHeight: CGFloat) {
        self.maxHeight = maxHeight
        super.init(frame: .zero)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.titleLabel, self.commitPhotoView, self.commentTextField, self.commitButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerY.equalToSuperview()
        }
        
        self.commitPhotoView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.trailing.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.height.equalTo(312)
        }
        
        self.commentTextField.snp.makeConstraints { make in
            make.top.equalTo(self.commitPhotoView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.trailing.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.height.equalTo(85)
        }
        
        self.commitButton.snp.makeConstraints { make in
            make.top.equalTo(29)
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.trailing.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.height.equalTo(57)
        }
    }

    
}
 
