//
//  HistoryViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol HistoryDisplayLogic: AnyObject {}

final class HistoryViewController: UIViewController {
    var interactor: HistoryBusinessLogic
    
    init(interactor: HistoryBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    lazy var navigationBar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: nil, leftButtonImage: .asset(.icon_back), rightButtonImage: .asset(.icon_more))
        v.delegate = self
        return v
    }()
    
    lazy var stateTagView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "30분이상 운동하기"
        v.font = .h2
        v.textColor = .primary
        return v
    }()
    
    lazy var certificationFailureLabel = {
        let v = UILabel()
        v.textColor = .grey500
        v.numberOfLines = 2
        v.setLineSpacing(10) // TODO: - 임시
        return v
    }()
    
    // TODO: - 공주 왕자 진행도 뷰 커스텀 한걸로 변경 필요
    lazy var progressBarView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var myNicknameTagView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var parterNicknameTagView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()

    lazy var certificationCollectionView = {
        let v = UICollectionView()
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        let guide = self.view.safeAreaLayoutGuide
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top).offset(13)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.stateTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(43)
            make.height.equalTo(24)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.stateTagView.snp.trailing).offset(11)
            make.centerY.equalTo(self.stateTagView)
        }
        
        self.certificationFailureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.progressBarView.snp.makeConstraints { make in
            make.top.equalTo(self.certificationFailureLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(203)
            make.height.equalTo(62)
        }
        
        self.myNicknameTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview().multipliedBy(0.25)
            make.width.equalTo(42)
            make.height.equalTo(21)
        }
        
        self.parterNicknameTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview().multipliedBy(0.75)
            make.width.equalTo(42)
            make.height.equalTo(21)
        }
        
        self.lineView.snp.makeConstraints { make in
            make.top.equalTo(self.myNicknameTagView.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        self.certificationCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.lineView.snp.bottom) // TODO: - 셀간의 간격을 17이다...
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(guide.snp.bottom)
        }
        
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension HistoryViewController: HistoryScene {
    
}

// MARK: - Display Logic

extension HistoryViewController: HistoryDisplayLogic {
    
}

// MARK: - Navigation Delegate
extension HistoryViewController: TTNavigationDetailBarDelegate {
    func didTapDetailLeftButton() {
        //
    }
    
    func didTapDetailRightButton() {
        //
    }
    
}
