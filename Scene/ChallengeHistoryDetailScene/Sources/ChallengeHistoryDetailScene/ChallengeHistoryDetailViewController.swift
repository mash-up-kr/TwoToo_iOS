//
//  ChallengeHistoryDetailViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeHistoryDetailDisplayLogic: AnyObject {
    func displayCertification(certification: ChallengeHistoryDetail.ViewModel.Challenge)
    func displayCompliment(compliment: ChallengeHistoryDetail.ViewModel.Compliment)
}

final class ChallengeHistoryDetailViewController: UIViewController {
    var interactor: ChallengeHistoryDetailBusinessLogic
    
    init(interactor: ChallengeHistoryDetailBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: nil,
                                rightButtonImage: .asset(.icon_cancel))
        v.delegate = self
        return v
    }()
    /// 인증 날짜 라벨
    private let dateLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textColor = .primary
        return v
    }()
    /// 챌린지 인증 이미지 뷰
    private lazy var certificateImageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    /// 챌린지 이름 라벨
    private lazy var challengeNameLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textColor = .primary
        return v
    }()
    /// 인증 소감
    private lazy var certificationCommentLabel: UILabel = {
        let v = UILabel()
        v.font = .h4
        v.textColor = .primary
        return v
    }()
    /// 인증 시간 라벨
    private lazy var timeLabel: UILabel = {
        let v = UILabel()
        v.font = .h4
        v.textColor = .grey500
        return v
    }()
    /// (상대방 닉네임) 가 보낸 칭찬
    private lazy var complimentTitleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .mainCoral
        v.isHidden = true
        return v
    }()
    /// 칭찬 문구 라벨
    private let complimentLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .body1
        v.numberOfLines = 0
        return v
    }()
    /// 칭찬 문구 라벨 배경 뷰
    private lazy var complimentContentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.addSubview(self.complimentLabel)
        v.isHidden = true
        return v
    }()
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        return v
    }()
    
    private lazy var scrollContentView: UIView = {
        let v = UIView()
        return v
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.view.backgroundColor = .second01
        Task {
            await self.interactor.didLoad()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        let leadingTrailingPadding: Int = 24
        let guide = self.view.safeAreaLayoutGuide

        self.scrollContentView.addSubviews(self.dateLabel,
                                           self.certificateImageView,
                                           self.challengeNameLabel,
                                           self.certificationCommentLabel,
                                           self.timeLabel,
                                           self.complimentTitleLabel,
                                           self.complimentContentView)
        self.scrollView.addSubview(self.scrollContentView)
        
        self.view.addSubviews(self.navigationBar,
                              self.scrollView)
        
        // MARK: - Layout
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        // ---> 컴포넌트
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(leadingTrailingPadding)
            make.trailing.equalToSuperview().inset(leadingTrailingPadding)
        }

        let widthHeight = UIScreen.main.bounds.width - CGFloat(leadingTrailingPadding * 2)
        self.certificateImageView.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(21)
            make.width.height.equalTo(widthHeight)
            make.centerX.equalToSuperview()
        }

        self.challengeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.certificateImageView.snp.bottom).offset(24)
            make.leading.equalTo(leadingTrailingPadding)
        }

        self.certificationCommentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.challengeNameLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(leadingTrailingPadding)
            make.trailing.equalToSuperview().inset(leadingTrailingPadding)
        }

        self.timeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.certificationCommentLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(leadingTrailingPadding)
        }

        // ---> 칭찬
        self.complimentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.timeLabel.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(leadingTrailingPadding)
        }

        self.complimentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
        }

        self.complimentContentView.snp.makeConstraints { make in
            make.top.equalTo(self.complimentTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(leadingTrailingPadding)
            make.trailing.equalToSuperview().inset(leadingTrailingPadding)
            make.bottom.equalToSuperview()
        }
      
        // ---> 스크롤뷰
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        self.scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

// MARK: - Navigation Delegate
extension ChallengeHistoryDetailViewController: TTNavigationBarDelegate {
    func didTapRightButton() {
        Task {
            await self.interactor.didTapCloseButton()
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension ChallengeHistoryDetailViewController: ChallengeHistoryDetailScene {
    
}

// MARK: - Display Logic

extension ChallengeHistoryDetailViewController: ChallengeHistoryDetailDisplayLogic {
    func displayCertification(certification: ChallengeHistoryDetail.ViewModel.Challenge) {
        self.navigationBar.titleLabel.text = certification.navigationTitle
        self.dateLabel.text = certification.certificationDateText
        self.certificateImageView.kf.setImage(with: certification.certificationImageURL)
        self.challengeNameLabel.text = certification.challengeName
        self.certificationCommentLabel.text = certification.certificationComment
        self.timeLabel.text = certification.certificationTimeText
    }
    
    func displayCompliment(compliment: ChallengeHistoryDetail.ViewModel.Compliment) {
        if !(compliment.complimentComment?.isEmpty ?? true) {
            self.complimentTitleLabel.isHidden = false
            self.complimentContentView.isHidden = false
            self.complimentTitleLabel.text = compliment.complimentTitle
            self.complimentLabel.text = compliment.complimentComment
            self.complimentLabel.setLineSpacing(8)
        }
        else {
            self.complimentTitleLabel.isHidden = true
            self.complimentContentView.isHidden = true
        }
    }
    
    
}
