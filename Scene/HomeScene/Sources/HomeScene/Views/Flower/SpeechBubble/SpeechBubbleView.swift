//
//  SpeechBubbleView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit

/// 말풍선 뷰
/// Parameter
/// - title : 말풍선 텍스트
/// - backgroundColor : 말풍선 배경
/// - tailPosition : 말풍선 꼬리 위치 (좌 / 우)
final class SpeechBubbleView: UIView {
    
    private let tipWidth: CGFloat = 10.0
    private let tipHeight: CGFloat = 6.0
    
    enum TailPosition: CGFloat {
        case left = 0.3
        case right = 0.7
    }
    
    let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .primary
        v.numberOfLines = 2
        return v
    }()
    
    init(title: String,
         backgroundColor: UIColor,
         tailPosition: TailPosition) {
        super.init(frame: .zero)
        self.layout()
        self.backgroundColor = backgroundColor
        self.titleLabel.text = title
        self.drawTip(bgColor: backgroundColor, tailPosition: tailPosition)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawTip(bgColor: UIColor, tailPosition: TailPosition) {
        let path = CGMutablePath()
        
        let padding: CGFloat = 10
        let width = self.titleLabel.intrinsicContentSize.width + (padding * 2)
        let height = self.titleLabel.intrinsicContentSize.height + (padding * 2)
        let tipStartX = width * tailPosition.rawValue

        let tipWidthCenter = tipWidth / 2.0
        let endXWidth = tipStartX + tipWidth

        path.move(to: CGPoint(x: tipStartX, y: height))
        path.addLine(to: CGPoint(x: tipStartX + tipWidthCenter, y: height + tipHeight))
        path.addLine(to: CGPoint(x: endXWidth, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = bgColor.cgColor

        self.layer.insertSublayer(shape, at: 0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
    }

    
    func layout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
