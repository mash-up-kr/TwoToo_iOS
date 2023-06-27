//
//  ChallengeRecommendBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit
import DesignSystem

final class ChallengeRecommendBottomSheetViewController: UIViewController, BottomSheetViewController {
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    private let challengeList: [String] = [
        "💗 사랑한다고 얘기 해주기",
        "📝 하루 한 문장 일상 공유하기",
        "👍 하루에 한번 칭찬 해주기",
        "📷 거울 셀카 찍기",
        "👗 패션 사진 OOTD 찍기",
        "🥦 하루 한끼 채식 식단 하기",
        "💵 하루 만원만 쓰기",
        "🏃‍♀️ 매일 운동하기",
        "🐷 체중 감량하기",
        "📘 독서하기",
        "🌞 미라클 모닝하기"
    ]
        
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textColor = .primary
        v.text = "챌린지 추천"
        return v
    }()
    
    private lazy var challengeListStackView: UIStackView = {
        let v = UIStackView()
        v.spacing = 16
        v.axis = .vertical
        v.alignment = .center
        self.challengeList.forEach {
            let tag = ChallengeRecommendTagView()
            tag.configure(title: $0)
            tag.delegate = self
            v.addArrangedSubview(tag)
        }
        return v
    }()
    
    private lazy var scrollSizeFitView: UIView = {
        let v = UIView()
        v.addSubviews(self.titleLabel,
                      self.challengeListStackView)
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let v = SelfSizingScrollView()
        v.addSubview(self.scrollSizeFitView)
        v.delegate = self
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.attribute()
    }
    
    private func layout() {
        self.view.addSubview(self.backScrollView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        
        self.challengeListStackView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        self.scrollSizeFitView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(24)
            make.width.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        self.backScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func attribute() {
        self.view.backgroundColor = .second02
    }
    
}

extension ChallengeRecommendBottomSheetViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}

extension ChallengeRecommendBottomSheetViewController: ChallengeRecommendTagViewDelegate {
    func didTapTagView(title: String, isTapped: Bool) {
        print(title, isTapped)
    }
}
