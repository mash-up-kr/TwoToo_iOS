//
//  TTNavigationBar.swift
//  
//
//  Created by Julia on 2023/06/19.
//

import UIKit
import Util

public protocol TTNavigationBarDelegate: AnyObject {
    func tapRightButton()
}

/// `TTNavigationBar`는 메인 화면 네비게이션에 사용되는 클래스입니다.
public final class TTNavigationBar: UIView {
    
    /// 버튼 이벤트 전달을 위한 델리게이트
    public weak var delegate: TTNavigationBarDelegate?
    
    /// 네비게이션 좌우 마진
    private let containerLeadingTrailingInset: CGFloat = 24
    
    // MARK: - UIComponent
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h1
        v.textColor = .mainPink
        return v
    }()
    
    private lazy var infoButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_info), for: .normal)
        v.addAction {
            self.delegate?.tapRightButton()
        }
        return v
    }()
            
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    /// - Parameters:
    ///  - title: 타이틀 설정
    ///  - rightButtonIsHidden: 오른쪽 버튼 숨기는 여부
    public convenience init(title: String,
                            infoButtonIsHidden: Bool) {
        self.init()
        self.titleLabel.text = title
        self.infoButton.isHidden = infoButtonIsHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func setUI() {
        [self.titleLabel, self.infoButton].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
            
        self.infoButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
    }
}
