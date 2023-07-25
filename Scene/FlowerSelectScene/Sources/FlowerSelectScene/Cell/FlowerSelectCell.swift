//
//  FlowerSelectCell.swift
//  
//
//  Created by Eddy on 2023/07/15.
//

import UIKit
import DesignSystem
import Worker

final class FlowerSelectCell: UICollectionViewCell {
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 7
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
        v.font = .h2
        v.textColor = .primary
        return v
    }()

    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.text = "행복한 사랑을 이루어 봐요"
        v.font = .body2
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .mainWhite
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: FlowerMappingWorker?) {
        guard let item else { return }
        self.flowerImageView.image = item.getBlurImage()
        self.titleLabel.text = item.getName()
        self.descriptionLabel.text = item.getDesc()
    }

    private func setLayout() {
        self.contentView.addSubviews(self.stackView, self.flowerImageView)
        self.contentView.layer.cornerRadius = 15

        self.stackView.addArrangedSubviews(
            self.titleLabel,
            self.descriptionLabel
        )

        self.flowerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(44.5)
            make.trailing.equalToSuperview().offset(-44.5)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalTo(self.stackView.snp.top).offset(-7)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.bottom.equalToSuperview().offset(-19)
        }
    }
}
