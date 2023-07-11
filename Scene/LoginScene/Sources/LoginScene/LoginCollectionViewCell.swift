//
//  LoginCollectionViewCell.swift
//  
//
//  Created by Eddy on 2023/07/09.
//

import UIKit
import DesignSystem

final class LoginCollectionViewCell: UICollectionViewCell {
    private lazy var onboardingImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()

    private lazy var onboardingLabel: UILabel = {
        let v = UILabel()
        v.font = .h1
        v.textColor = .primary
        v.numberOfLines = 0
        v.textAlignment = .center
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setUI()
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage, text: String) {
        self.onboardingImageView.image = image
        self.onboardingLabel.text = text
    }

    private func setUI() {
        self.backgroundColor = .white
        self.contentView.addSubviews(self.onboardingImageView, self.onboardingLabel)
    }

    private func setLayout() {
        self.onboardingImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.96)
        }

        self.onboardingLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.onboardingImageView.snp.bottom).offset(10)
        }
    }
}
