//
//  TTBottomSheetCommitPhotoView.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import UIKit

public protocol TTBottomSheetCommitPhotoViewDelegate: AnyObject {
    func didTapPlusButton()
}

/// 인증하기 바텀 시트 내부의 사진 첨부 뷰 입니다.
public final class TTBottomSheetCommitPhotoView: UIImageView {
    
    // TODO: 사진이 있을 때와 없을 때 구분이 필요합니다.
    
    public weak var delegate: TTBottomSheetCommitPhotoViewDelegate?
    
    private lazy var plusButton: UIButton = {
        let v = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium)
        v.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        v.tintColor = .mainWhite
        // TODO: 버튼 터치 이벤트 동작 안함
        v.addTapAction { [weak self] in
            self?.delegate?.didTapPlusButton()
            print("tap!")
        }
        return v
    }()
    
    private lazy var cameraGuideLabel: UILabel = {
        let v = UILabel()
        v.text  = "사진 촬영하기 / 앨범에서 가져오기"
        v.font = .body1
        v.textColor = .mainWhite
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 14
        v.distribution = .fill
        [self.plusButton, self.cameraGuideLabel].forEach {
            v.addArrangedSubview($0)
        }
        return v
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func attribute() {
        self.backgroundColor = .mainPink.withAlphaComponent(0.3)
        self.layer.cornerRadius = 15
        self.contentMode = .scaleToFill
    }
    
    /// 사진을 촬영하거나 사진첩에세 이미지를 가져오면 업데이트 합니다.
    public func updateImage(_ photo: UIImage) {
        self.image = photo
        self.stackView.isHidden = true
    }
    
}
