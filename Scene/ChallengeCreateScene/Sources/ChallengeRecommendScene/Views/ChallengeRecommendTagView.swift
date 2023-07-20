//
//  ChallengeRecommendBottomSheetCell.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit

protocol ChallengeRecommendTagViewDelegate: AnyObject {
    func didTapTagView(title: String, isTapped: Bool)
}

final class ChallengeRecommendTagView: UIView {
    
    weak var delegate: ChallengeRecommendTagViewDelegate?
    
    private var tagTitle: String?
    private var isTapped: Bool = false {
        didSet {
            let backgroundColor: UIColor = isTapped ? .second01 : .mainWhite
            self.backgroundColor = backgroundColor
        }
    }

    private let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h4
        v.textColor = .primary
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
        self.didTapTagView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ChallengeRecommend.ViewModel.Challenges.Challenge) {
        self.titleLabel.text = "\(model.title.icon) \(model.title.challengeName)"
        self.tagTitle = model.title.challengeName
    }
    
    private func layout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func attribute() {
        self.backgroundColor = .mainWhite
        self.layer.cornerRadius = 20
    }
    
    private func didTapTagView() {
        self.addTapAction { [weak self] in
            if let title = self?.tagTitle,
                let isTapped = self?.isTapped {
                self?.delegate?.didTapTagView(title: title, isTapped: isTapped)
                self?.isTapped.toggle()
            }
        }
    }
    
}

 
