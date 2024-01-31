//
//  ChallengeRecommendViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeRecommendDisplayLogic: AnyObject {
    func displayChallenges(viewModel: ChallengeRecommend.ViewModel.Challenges)
}

final class ChallengeRecommendViewController: UIViewController, BottomSheetViewController {
    var interactor: ChallengeRecommendBusinessLogic
    
    init(interactor: ChallengeRecommendBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
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
        return v
    }()
    
    private lazy var scrollSizeFitView: UIView = {
        let v = UIView()
        v.addSubviews(self.titleLabel,
                      self.challengeListStackView)
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let heightRatio = UIDevice.current.deviceType == .default ? 0.8 : 0.67
        let v = SelfSizingScrollView(maxHeightRatio: heightRatio)
        v.addSubview(self.scrollSizeFitView)
        v.delegate = self
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        
        Task {
            await self.interactor.didLoad()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        
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
}

// MARK: - Trigger

extension ChallengeRecommendViewController: ChallengeRecommendTagViewDelegate,
                                            UIScrollViewDelegate {
    
    func didTapTagView(title: String, isTapped: Bool) {
        Task {
            await self.interactor.didSelectRecommendChallenge(challengeName: title)
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}

// MARK: - Trigger by Parent Scene

extension ChallengeRecommendViewController: ChallengeRecommendScene {
    
    var bottomSheetViewController: UIViewController {
        return TTBottomSheetViewController(contentViewController: self)
    }
}

// MARK: - Display Logic

extension ChallengeRecommendViewController: ChallengeRecommendDisplayLogic {
    
    func displayChallenges(viewModel: ChallengeRecommend.ViewModel.Challenges) {
        viewModel.items.unwrap {
            $0.forEach { item in
                let tag = ChallengeRecommendTagView()
                tag.configure(model: item)
                tag.delegate = self
                self.challengeListStackView.addArrangedSubview(tag)
            }
        }
    }
}
