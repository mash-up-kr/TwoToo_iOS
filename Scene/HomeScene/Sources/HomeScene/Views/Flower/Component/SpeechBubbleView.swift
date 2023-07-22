//
//  SpeechBubbleView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import DesignSystem

/// 말풍선 뷰
///
/// Parameter
/// - title : 말풍선 텍스트
/// - tailPosition : 말풍선 꼬리 위치 (좌 / 우)
final class SpeechBubbleView: UIView {
    
    private var _backgroundColor: UIColor = .white
    private var tailCoordinate: CGFloat = 0.5
    
    enum TailPosition{
        case partner
        case my
    }
    
    let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .primary
        v.numberOfLines = 0
        return v
    }()
    
    lazy var tailImageView: UIImageView = {
        let v = UIImageView()
        v.frame = .init(x: 0, y: 0, width: 10, height: 10)
        return v
    }()
    
    init(tailPosition: TailPosition) {
        super.init(frame: .zero)
        switch tailPosition {
        case .partner:
            self._backgroundColor = UIColor.mainLightPink
            self.tailCoordinate = 0.5
            self.tailImageView.image = UIImage.asset(.icon_bubble_tail_partner)
        case .my:
            self._backgroundColor = UIColor.second01
            self.tailCoordinate = 1.5
            self.tailImageView.image = UIImage.asset(.icon_bubble_tail_my)
        }
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubviews(self.titleLabel,
                        self.tailImageView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        self.tailImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(10)
            make.centerX.equalToSuperview().multipliedBy(self.tailCoordinate)
        }
    }
    
    func attribute() {
        self.layer.cornerRadius = 8
        self.backgroundColor = _backgroundColor
    }
    
    func configure(title: String) {
        if title.count > 10 {
            let index = title.index(title.startIndex, offsetBy: 10)
            let firstPart = title[..<index]
            let secondPart = title[index...]
            let newTitle = "\(firstPart)\n\(secondPart)"
            self.titleLabel.text = newTitle
        } else {
            self.titleLabel.text = title
        }
    }

}
