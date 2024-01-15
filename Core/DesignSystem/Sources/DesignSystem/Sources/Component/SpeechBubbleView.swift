//
//  SpeechBubbleView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit

/// 말풍선 뷰
///
/// Parameter
/// - title : 말풍선 텍스트
/// - tailPosition : 말풍선 꼬리 위치 (좌 / 우)
final public class SpeechBubbleView: UIView {
    
    private var _backgroundColor: UIColor = .white
    private var tailCoordinate: CGFloat = 0.5
    private var tailPosition: TailPosition = .my
    
    public enum TailPosition{
        /// 홈 - 파트너 말풍선
        case partner
        /// 홈 - 내 말풍선
        case my
        /// 챌린지 대기중 - 나가기 말풍선
        case exit
    }
    
    public let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textAlignment = .center
        v.textColor = .primary
        v.numberOfLines = 0
        return v
    }()
    
    lazy var tailImageView: UIImageView = {
        let v = UIImageView()
        v.frame = .init(x: 0, y: 0, width: 10, height: 10)
        return v
    }()
    
    public init(tailPosition: TailPosition) {
        super.init(frame: .zero)
        self.tailPosition = tailPosition
        switch tailPosition {
        case .partner:
            self._backgroundColor = UIColor.mainLightPink
            self.tailCoordinate = 0.5
            self.tailImageView.image = UIImage.asset(.icon_bubble_tail_partner)
        case .my:
            self._backgroundColor = UIColor.second01
            self.tailCoordinate = 1.5
            self.tailImageView.image = UIImage.asset(.icon_bubble_tail_my)
        case .exit:
            self._backgroundColor = UIColor.second01
//            self.tailImageView.image = UIImage(resource: .iconBubbleTailExit)
            self.tailCoordinate = 1.7
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
        switch tailPosition {
        case .partner, .my:
            self.tailImageView.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(10)
                make.centerX.equalToSuperview().multipliedBy(self.tailCoordinate)
            }
        case .exit:
            self.tailImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(-10)
                make.centerX.equalToSuperview().multipliedBy(self.tailCoordinate)
            }
        }

    }
    
    func attribute() {
        self.layer.cornerRadius = 8
        self.backgroundColor = _backgroundColor
    }
    
    public func configure(title: String) {
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
