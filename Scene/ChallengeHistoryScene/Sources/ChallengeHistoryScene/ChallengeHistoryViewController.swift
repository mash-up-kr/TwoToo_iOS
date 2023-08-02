//
//  ChallengeHistoryViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit
import DesignSystem
import Util

protocol ChallengeHistoryDisplayLogic: AnyObject {
    func displayChallenge(viewModel: ChallengeHistory.ViewModel.Challenge)
    func displayOptionPopup(title: String)
    func displayQuitPopup(viewModel: ChallengeHistory.ViewModel.QuitPopup)
    func dismissQuitPopup()
    func displayToast(message: String)
}

final class ChallengeHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var interactor: ChallengeHistoryBusinessLogic
    
    init(interactor: ChallengeHistoryBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var navigationBar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: nil,
                                      leftButtonImage: .asset(.icon_back),
                                      rightButtonImage: .asset(.icon_more))
        v.delegate = self
        return v
    }()
    
    private let dDayTagView: TTTagView = {
        let v = TTTagView(textColor: .grey500,
                          fontSize: .body1,
                          cornerRadius: 4)
        return v
    }()
    
    private let titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h2
        return v
    }()
    
    private let additionalInfoLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey500
        v.font = .body1
        v.numberOfLines = 2
        v.lineBreakMode = .byTruncatingTail
        return v
    }()
    
    private let myNicknameTagView: TTTagView = {
        let v = TTTagView(textColor: .mainCoral,
                          fontSize: .body2,
                          cornerRadius: 15)
        v.isHidden = true
        return v
    }()
    
    private let partnerNicknameTagView: TTTagView = {
        let v = TTTagView(textColor: .primary,
                          fontSize: .body2,
                          cornerRadius: 15)
        v.isHidden = true
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
    
    lazy var popupView: TTPopup = {
        let v = TTPopup()
        v.isHidden = true
        v.didTapLeftButton {
            Task {
                await self.interactor.didTapQuitPopupCancelButton()
            }
        }
        v.didTapRightButton {
            Task {
                await self.interactor.didTapQuitPopupQuitButton()
            }
        }
        v.didTapBackground {
            Task {
                await self.interactor.didTapQuitPopupBackground()
            }
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            await self.interactor.didAppear()
        }
    }
    
    @objc private func viewDidAppearWithModalDismissed() {
        Task {
            await self.interactor.didAppear()
        }
    }
    
    private func registNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.viewDidAppearWithModalDismissed),
            name: NSNotification.Name("modal_dismissed"),
            object: nil
        )
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        
        self.view.addSubviews(self.navigationBar,
                              self.dDayTagView,
                              self.titleLabel,
                              self.additionalInfoLabel,
                              self.myNicknameTagView,
                              self.partnerNicknameTagView,
                              self.underLineView,
                              self.certificateTableView,
                              self.popupView)
        
        self.view.bringSubviewToFront(self.popupView)
        
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
            make.height.equalTo(28)
        }
        
        self.myNicknameTagView.snp.makeConstraints { make in
            make.top.equalTo(self.additionalInfoLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview().multipliedBy(1.5)
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
                
        self.popupView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(349)
        }
    }
    // MARK: - UITableViewDataSource
    var certificateList: ChallengeHistory.ViewModel.CellInfoList = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.certificateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: CertificateTableViewCell.self, indexPath: indexPath)
        cell.configure(viewModel: self.certificateList[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Cell Delegate
extension ChallengeHistoryViewController: CertificateTableViewCellDelegate {
    func didTapUserCell(id: String, willCertificate: Bool) {
        if willCertificate {
            Task {
                await self.interactor.didTapCertificate()
            }
        } else if !id.isEmpty {
            Task {
                await self.interactor.didSelectCertificate(certificateID: id)
            }
        }
    }
    
    func didTapPartnerCell(id: String) {
        if !id.isEmpty {
            Task {
                await self.interactor.didSelectCertificate(certificateID: id)
            }
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension ChallengeHistoryViewController: ChallengeHistoryScene {
    
}

// MARK: - Display Logic

extension ChallengeHistoryViewController: ChallengeHistoryDisplayLogic {

    func displayQuitPopup(viewModel: ChallengeHistory.ViewModel.QuitPopup) {
        self.popupView.configure(title: viewModel.title,
                                 resultView: UIImageView(image: viewModel.iconImage),
                                 description: viewModel.description,
                                 buttonTitles: viewModel.buttonTitles)
        self.popupView.isHidden = false
    }
    
    func displayChallenge(viewModel: ChallengeHistory.ViewModel.Challenge) {
        self.myNicknameTagView.isHidden = false
        self.partnerNicknameTagView.isHidden = false
        self.dDayTagView.titleLabel.text = viewModel.dDayText
        self.titleLabel.text = viewModel.name
        self.additionalInfoLabel.text = viewModel.additionalInfo
        self.additionalInfoLabel.setLineSpacing(8)
        self.myNicknameTagView.titleLabel.text = viewModel.myNickname
        self.partnerNicknameTagView.titleLabel.text = viewModel.partnerNickname
        self.certificateList = viewModel.cellInfo
        self.certificateTableView.reloadData()
        
        if viewModel.dDayText == "완료" {
            self.navigationBar.setIsHiddenRightButton(true)
        }
        else {
            self.navigationBar.setIsHiddenRightButton(false)
        }
    }

    func displayOptionPopup(title: String) {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { [weak self] _ in
            Task {
                await self?.interactor.didTapOptionPopupQuitButton()
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            Task {
                await self.interactor.didTapQuitPopupCancelButton()
            }
        }
        alertVC.addAction(action)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true)
    }
    
    func dismissQuitPopup() {
        self.popupView.isHidden = true
    }
    
    func displayToast(message: String) {
        Toast.shared.makeToast(message)
    }
    
}

extension ChallengeHistoryViewController: TTNavigationDetailBarDelegate {
    func didTapDetailLeftButton() {
        Task {
            await self.interactor.didTapBackButton()
        }
    }
    
    func didTapDetailRightButton() {
        Task {
            await self.interactor.didTapOptionButton()
        }
    }
    
}
