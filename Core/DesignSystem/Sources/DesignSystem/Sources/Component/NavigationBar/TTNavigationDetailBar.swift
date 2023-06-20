//
//  TTNavigationDetailBar.swift
//  
//
//  Created by Julia on 2023/06/20.
//

import UIKit
import Util

public protocol TTNavigationDetailBarDelegate: AnyObject {
    func didTapDetailMoreButton()
    func didTapDetailBackButton()
}

/// `TTNavigationDetailBar`는 상세 화면 네비게이션에 사용되는 클래스입니다.
public final class TTNavigationDetailBar: UIView {

    /// 버튼 이벤트 전달을 위한 델리게이트
    public weak var delegate: TTNavigationDetailBarDelegate?
    
    /// 네비게이션 좌우 마진
    private let containerLeadingTrailingInset: CGFloat = 16
    
    // MARK: - UI Component
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textColor = .primary
        return v
    }()
    
    private lazy var backButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_back), for: .normal)
        v.addAction {
            self.delegate?.didTapDetailMoreButton()
        }
        return v
    }()
    
    private lazy var moreButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_more), for: .normal)
        v.addAction {
            self.delegate?.didTapDetailBackButton()
        }
        return v
    }()
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    /// - Parameters:
    ///  - title: 타이틀 설정 (optional)
    ///  - moreButtonIsHidden: 우측 버튼 숨기는 여부
    ///  사용 예시
    ///  ```swift
    /// TTNavigationDetailBar(title: nil, infoButtonIsHidden: true)
    ///  ```
    public convenience init(title: String?,
                            moreButtonIsHidden: Bool) {
        self.init()
        self.titleLabel.text = title
        self.moreButton.isHidden = moreButtonIsHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func setUI() {
        [self.titleLabel, self.backButton, self.moreButton].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
        
        self.moreButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
    }
}
