//
//  TTNavigationBar.swift
//  
//
//  Created by Julia on 2023/06/19.
//

import UIKit
import Util

public protocol TTNavigationBarDelegate: AnyObject {
    func didTapRightButton()
}

/// `TTNavigationBar`는 메인 화면 네비게이션에 사용되는 클래스입니다.
public final class TTNavigationBar: UIView {
    
    /// 버튼 이벤트 전달을 위한 델리게이트
    public weak var delegate: TTNavigationBarDelegate?
    
    /// 네비게이션 좌우 마진
    private let containerLeadingTrailingInset: CGFloat = 24
    
    // MARK: - UIComponent
    
    public lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h1
        v.textColor = .mainPink
        return v
    }()
    
    private lazy var rightButton: UIButton = {
        let v = UIButton()
        v.addAction { [weak self] in
            self?.delegate?.didTapRightButton()
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
    ///  - rightButtonImage: 우측 버튼 이미지 설정
    ///   ///  사용 예시
    ///  ```swift
    /// TTNavigationBar(title: "마이페이지", rightButtonImage: .asset(.icon_info))
    ///  ```
    public convenience init(title: String?,
                            rightButtonImage: UIImage?) {
        self.init()
        self.titleLabel.text = title
        self.rightButton.setImage(rightButtonImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func setUI() {
        [self.titleLabel, self.rightButton].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
            
        self.rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
    }
}
