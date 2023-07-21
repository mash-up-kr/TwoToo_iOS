//
//  FlowerSelectCell.swift
//  
//
//  Created by Eddy on 2023/07/15.
//

import UIKit

final class FlowerSelectCell: UICollectionViewCell {
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical

        return v
    }()

    private lazy var flowerImageView: UIImageView = {
        let v = UIImageView()

        return v
    }()

    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "장미"
        v.textAlignment = .center
        v.font = .systemFont(ofSize: 24)

        return v
    }()

    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.text = "행복한 사랑을 이루어 봐요"
        v.font = .systemFont(ofSize: 15)

        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: String, title: String, description: String) {
        self.flowerImageView.image = UIImage(systemName: image)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }

    private func setLayout() {
        self.contentView.addSubview(stackView)

        self.stackView.addArrangedSubviews(
            self.flowerImageView,
            self.titleLabel,
            self.descriptionLabel
        )

        self.stackView.setCustomSpacing(7, after: self.flowerImageView)
        self.stackView.setCustomSpacing(7, after: self.titleLabel)

        self.stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.height.equalTo(self.descriptionLabel.snp.width).multipliedBy(0.3)
        }

        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.height.equalTo(self.descriptionLabel.snp.width).multipliedBy(0.1)
        }

        self.flowerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
        }
    }
}
