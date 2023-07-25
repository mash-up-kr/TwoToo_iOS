//
//  ChallengeHistoryViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeHistoryDisplayLogic: AnyObject {}

final class ChallengeHistoryViewController: UIViewController {
    var interactor: ChallengeHistoryBusinessLogic
    
    init(interactor: ChallengeHistoryBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private let navigationBar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: nil,
                                      leftButtonImage: .asset(.icon_back),
                                      rightButtonImage: .asset(.icon_more))
        return v
    }()
    
    private let dDayTagView: TTTagView = {
        let v = TTTagView(textColor: .grey500,
                          fontSize: .body1,
                          cornerRadius: 4)
        v.titleLabel.text = "D-24"
        return v
    }()
    
    private let titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h2
        v.text = "30분 게임하기"
        return v
    }()
    
    private let additionalInfoLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey500
        v.font = .body1
        v.numberOfLines = 2
        v.lineBreakMode = .byTruncatingTail
        v.text = "운동사진으로 인증하기\n실패하는 사람은 뷔페 쏘기"
        v.setLineSpacing(5)
        return v
    }()
    
    private let myNicknameTagView: TTTagView = {
        let v = TTTagView(textColor: .mainCoral,
                          fontSize: .body2,
                          cornerRadius: 15,
                          edgeInsets: UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10))
        v.titleLabel.text = "나나"
        return v
    }()
    
    private let partnerNicknameTagView: TTTagView = {
        let v = TTTagView(textColor: .primary,
                          fontSize: .body2,
                          cornerRadius: 15,
                          edgeInsets: UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10))
        v.titleLabel.text = "상대"
        return v
    }()
    
    private let underLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var certificateTableView: UITableView = {
        let v = UITableView()
        v.rowHeight = 161
        v.dataSource = self
        v.delegate = self
        v.registerCell(CertificateTableViewCell.self)
        v.backgroundColor = .clear
        v.separatorStyle = .none
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .second02
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.navigationBar,
                              self.dDayTagView,
                              self.titleLabel,
                              self.additionalInfoLabel,
                              self.myNicknameTagView,
                              self.partnerNicknameTagView,
                              self.underLineView,
                              self.certificateTableView)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.dDayTagView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(50)
            make.height.equalTo(24)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(9)
            make.leading.equalTo(self.dDayTagView.snp.trailing).offset(11)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.additionalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        
        self.partnerNicknameTagView.snp.makeConstraints { make in
            make.top.equalTo(self.additionalInfoLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(42)
            make.height.equalTo(28)
        }
        
        self.myNicknameTagView.snp.makeConstraints { make in
            make.top.equalTo(self.additionalInfoLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.width.equalTo(42)
            make.height.equalTo(28)
        }
            
        self.underLineView.snp.makeConstraints { make in
            make.top.equalTo(self.myNicknameTagView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        self.certificateTableView.snp.makeConstraints { make in
            make.top.equalTo(self.underLineView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
                
    }
}

extension ChallengeHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: CertificateTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension ChallengeHistoryViewController: ChallengeHistoryScene {
    
}

// MARK: - Display Logic

extension ChallengeHistoryViewController: ChallengeHistoryDisplayLogic {
    
}
