//
//  TTNavigationDetailBar.swift
//  
//
//  Created by Julia on 2023/06/20.
//

import UIKit
import Util

public protocol TTNavigationDetailBarDelegate: AnyObject {
    func didTapDetailLeftButton()
    func didTapDetailRightButton()
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
    
    private lazy var leftButton: UIButton = {
        let v = UIButton()
        v.addAction { [weak self] in
            self?.delegate?.didTapDetailLeftButton()
        }
        return v
    }()
    
    private lazy var rightButton: UIButton = {
        let v = UIButton()
        v.addAction { [weak self] in
            self?.delegate?.didTapDetailRightButton()
        }
        return v
    }()
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    /// - Parameters:
    ///  - title: 타이틀 설정
    ///  - leftButtonImage: 좌측 버튼 이미지 설정
    ///  - rightButtonImage: 우측 버튼 이미지 설정
    ///  사용 예시
    ///  ```swift
    /// TTNavigationDetailBar(title: "Hello",
    ///                       leftButtonImage: .asset(.icon_more),
    ///                       rightButtonImage: nil)
    ///  ```
    public convenience init(title: String?,
                            leftButtonImage: UIImage?,
                            rightButtonImage: UIImage?) {
        self.init()
        self.titleLabel.text = title
        self.leftButton.setImage(leftButtonImage, for: .normal)
        self.rightButton.setImage(rightButtonImage , for: .normal)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func layout() {
        [self.titleLabel, self.leftButton, self.rightButton].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
        
        self.rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(self.containerLeadingTrailingInset)
            make.centerY.equalToSuperview()
        }
    }
}
