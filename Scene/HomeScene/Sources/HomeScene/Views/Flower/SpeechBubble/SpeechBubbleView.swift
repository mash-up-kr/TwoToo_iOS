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
/// - tailPosition : 말풍선 꼬리 위치 (좌 / 우)
final class SpeechBubbleView: UIView {
    
    private let tipWidth: CGFloat = 12.0
    private let tipHeight: CGFloat = 8.0
    private var _backgroundColor: UIColor = .white
    private var tailCoordinate: CGFloat = 0.5
    
    enum TailPosition {
        case left
        case right
    }
    
    let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .primary
        v.numberOfLines = 0
        return v
    }()
    
    init(title: String,
         tailPosition: TailPosition) {
        super.init(frame: .zero)
        self.layout()
        switch tailPosition {
        case .left:
            self._backgroundColor = .mainLightPink
            self.tailCoordinate = 0.3
        case .right:
            self._backgroundColor = .second01
            self.tailCoordinate = 0.7
        }
        self.titleLabel.text = title
        self.backgroundColor = _backgroundColor
        self.drawTip(bgColor: self._backgroundColor,
                     tailPosition: tailCoordinate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawTip(bgColor: UIColor, tailPosition: CGFloat) {
        let path = CGMutablePath()
        
        let padding: CGFloat = 10
        let width = self.titleLabel.intrinsicContentSize.width + (padding * 2)
        let height = self.titleLabel.intrinsicContentSize.height + (padding * 2)
        let tipStartX = width * tailPosition

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
