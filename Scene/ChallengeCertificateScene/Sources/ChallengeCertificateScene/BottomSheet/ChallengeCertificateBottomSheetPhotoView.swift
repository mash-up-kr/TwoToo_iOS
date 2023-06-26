//
//  ChallengeCertificateBottomSheetPhotoView.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit

public protocol ChallengeCertificateBottomSheetPhotoViewDelegate: AnyObject {
    func didTapPlusButton()
}

public final class ChallengeCertificateBottomSheetPhotoView: UIView {
        
    public weak var delegate: ChallengeCertificateBottomSheetPhotoViewDelegate?
    
    private lazy var plusButton: UIButton = {
        let v = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium)
        v.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        v.tintColor = .mainWhite
        v.addAction { [weak self] in
            self?.delegate?.didTapPlusButton()
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
    
    private lazy var descriptionStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 14
        v.distribution = .fill
        [self.plusButton, self.cameraGuideLabel].forEach {
            v.addArrangedSubview($0)
        }
        return v
    }()
    
    private lazy var photoView: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .mainPink.withAlphaComponent(0.3)
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
        self.addSubviews(self.photoView, self.descriptionStackView)
        
        self.photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.descriptionStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func attribute() {
        self.layer.cornerRadius = 15
        self.contentMode = .scaleToFill
    }

    /// 사진을 촬영하거나 사진첩에서 이미지를 가져오면 업데이트 합니다.
    public func updateImage(_ photo: UIImage) {
        self.photoView.image = photo
    }
    
}
