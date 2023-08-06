//
//  MyInfoViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol MyInfoDisplayLogic: AnyObject {
    func displayLists(viewModel: MyInfo.ViewModel.Lists)
    func displayMyInfo(viewModel: MyInfo.ViewModel.Data)
    func displayToast(viewModel: MyInfo.ViewModel.Toast)
    /// 회원탈퇴 팝업을 보여준다.
    func displaySignOutPopup(viewModel: MyInfo.ViewModel.SignOutViewModel)
    /// 회원 탈퇴 완료 팝업을 보여준다.
    func displaySignOutCompletePopup(viewModel: MyInfo.ViewModel.SignOutCompletedViewModel)
    /// 회원탈퇴 취소 팝업을 보여준다.
    func displaySignOutCancelPopup(viewModel: MyInfo.ViewModel.SignOutCancelViewModel)
    /// 회원탈퇴 취소 완료 팝업을 보여준다.
    func displaySignOutCancelCompletePopup(viewModel: MyInfo.ViewModel.SignOutCancelCompletedViewModel)
}

final class MyInfoViewController: UIViewController {
    var interactor: MyInfoBusinessLogic
    
    private var myInfoLists: [MyInfo.ViewModel.Lists.Item] = []
    
    // MARK: - UI
    
    private lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "마이페이지", rightButtonImage: .asset(.icon_info))
        v.delegate = self
        return v
    }()
    
    private lazy var mainImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_nicknam_my)
        return v
    }()

    private lazy var nameStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 9
        return v
    }()
    
    private lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.textColor = .mainCoral
        v.font = .body3
        return v
    }()

    private lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.textColor = .mainCoral
        v.font = .body3
        return v
    }()

    private lazy var heartImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_heart)
        return v
    }()
    
    private lazy var challengeCountLabel: UILabel = {
        let v = UILabel()
        v.textColor = .mainCoral
        v.font = .body3
        return v
    }()
    
    private lazy var myNameTagView: TTTagView = {
        let v = TTTagView(textColor: .primary, fontSize: .body2, cornerRadius: 15)
        return v
    }()
    
    private lazy var separator: TTSeparator = {
        let v = TTSeparator(color: .second01, height: 3)
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero)
        v.registerCell(MyInfoTableViewCell.self)
        v.setBackgroundDefault()
        v.dataSource = self
        v.delegate = self
        v.separatorStyle = .none
        v.isScrollEnabled = false
        return v
    }()

    var signOutPopupView: TTPopup?

    var signOutCompletePopupView: TTPopup?

    var signOutCancelPopupView: TTPopup?

    var signoutCancelCompletePopupView: TTPopup?
    
    init(interactor: MyInfoBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        
        Task {
            Loading.shared.showLoadingView()
            await self.interactor.didLoad()
            Loading.shared.stopLoadingView()
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()

        self.nameStackView.addArrangedSubviews(self.myNicknameLabel, self.heartImageView, self.partnerNicknameLabel)
        self.view.addSubviews(
            self.navigationBar, self.mainImageView,
            self.nameStackView, self.challengeCountLabel,
            self.myNameTagView, self.separator, self.tableView
        )
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.mainImageView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(113)
            make.height.equalTo(UIScreen.main.bounds.height * 0.158)
        }
        
        self.nameStackView.snp.makeConstraints { make in
            make.top.equalTo(self.mainImageView.snp.bottom).offset(19)
            make.centerX.equalTo(self.mainImageView.snp.centerX)
        }

        self.heartImageView.snp.makeConstraints { make in
            make.height.width.equalTo(10)
        }
        
        self.challengeCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.myNicknameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.mainImageView.snp.centerX)
        }
        
        self.myNameTagView.snp.makeConstraints { make in
            make.top.equalTo(self.challengeCountLabel.snp.bottom).offset(14)
            make.centerX.equalTo(self.mainImageView.snp.centerX)
        }
        
        self.separator.snp.makeConstraints { make in
            make.top.equalTo(self.myNameTagView.snp.bottom).offset(34)
            make.leading.trailing.equalToSuperview()
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.separator.snp.bottom).offset(11)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Trigger

extension MyInfoViewController: TTNavigationBarDelegate {
    func didTapRightButton() {
        Task {
            await self.interactor.didTapGuideButton()
        }
    }
}

// MARK: - Trigger by Parent Scene

extension MyInfoViewController: MyInfoScene {
    
}


// MARK: - Display Logic

extension MyInfoViewController: MyInfoDisplayLogic {
    func displaySignOutPopup(viewModel: MyInfo.ViewModel.SignOutViewModel) {
        self.displayWithAnimation { [weak self] in
            viewModel.show.unwrap {
                let popupContentView = UIView()
                let imageView = UIImageView()
                imageView.image = $0
                imageView.contentMode = .scaleAspectFit
                popupContentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }

                let popupView = TTPopup()
                popupView.configure(title: MyInfo.ViewModel.SignOutViewModel.title,
                                    resultView: popupContentView,
                                    description: MyInfo.ViewModel.SignOutViewModel.message,
                                    buttonTitles: [
                                        MyInfo.ViewModel.SignOutViewModel.cancelOptionText,
                                        MyInfo.ViewModel.SignOutViewModel.signOutOptionText
                                    ])

                popupView.didTapLeftButton {
                    Task {
                        await self?.interactor.didTapSignOutPopupCancelButton()
                    }
                }

                popupView.didTapRightButton {
                    Task {
                        await self?.interactor.didTapSignoutPopupSignOutButton()
                    }
                }

                popupView.didTapBackground {
                    Task {
                        await self?.interactor.didTapSignOutPopupBackground()
                    }
                }

                self?.signOutPopupView = popupView

                if let signOutPopupView = self?.signOutPopupView {
                    self?.view.addSubview(signOutPopupView)
                }
            }

            viewModel.dismiss.unwrap {
                self?.signOutPopupView?.removeFromSuperview()
                self?.signOutPopupView = nil
            }
        }
    }

    func displaySignOutCompletePopup(viewModel: MyInfo.ViewModel.SignOutCompletedViewModel) {
        self.displayWithAnimation { [weak self] in
            viewModel.show.unwrap {
                let popupContentView = UIView()
                let imageView = UIImageView()
                imageView.image = $0
                imageView.contentMode = .scaleAspectFit
                popupContentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }

                let popupView = TTPopup()
                popupView.configure(title: MyInfo.ViewModel.SignOutCompletedViewModel.title,
                                    resultView: popupContentView,
                                    description: MyInfo.ViewModel.SignOutCompletedViewModel.message,
                                    buttonTitles: [
                                        MyInfo.ViewModel.SignOutCompletedViewModel.confirmOptionText
                                    ])

                popupView.didTapLeftButton {
                    Task {
                        await self?.interactor.didTapSignOutCompleteConfirmButton()
                    }
                }


                popupView.didTapBackground {
                    Task {
                        await self?.interactor.didTapSignOutCompletePopupBackground()
                    }
                }

                self?.signOutCompletePopupView = popupView

                if let signOutCompletePopupView = self?.signOutCompletePopupView {
                    self?.view.addSubview(signOutCompletePopupView)
                }
            }

            viewModel.dismiss.unwrap {
                self?.signOutCompletePopupView?.removeFromSuperview()
                self?.signOutCompletePopupView = nil
            }
        }
    }

    func displaySignOutCancelPopup(viewModel: MyInfo.ViewModel.SignOutCancelViewModel) {
        self.displayWithAnimation { [weak self] in
            viewModel.show.unwrap {
                let popupContentView = UIView()
                let imageView = UIImageView()
                imageView.image = $0
                imageView.contentMode = .scaleAspectFit
                popupContentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }

                let popupView = TTPopup()
                popupView.configure(title: MyInfo.ViewModel.SignOutCancelViewModel.title,
                                    resultView: popupContentView,
                                    description: MyInfo.ViewModel.SignOutCancelViewModel.message,
                                    buttonTitles: [
                                        MyInfo.ViewModel.SignOutCancelViewModel.noOptionText,
                                        MyInfo.ViewModel.SignOutCancelViewModel.SingOutCancelOptionText
                                    ])

                popupView.didTapLeftButton {
                    Task {
                        await self?.interactor.didTapSignOutCancelCompleteNobutton()
                    }
                }

                popupView.didTapRightButton {
                    Task {
                        await self?.interactor.didTapCancelSignOutCancelButton()
                    }
                }

                popupView.didTapBackground {
                    Task {
                        await self?.interactor.didTapSignOutCancelPopupBackground()
                    }
                }

                self?.signOutCancelPopupView = popupView

                if let signOutCancelPopupView = self?.signOutCancelPopupView {
                    self?.view.addSubview(signOutCancelPopupView)
                }
            }

            viewModel.dismiss.unwrap {
                self?.signOutCancelPopupView?.removeFromSuperview()
                self?.signOutCancelPopupView = nil
            }
        }
    }

    func displaySignOutCancelCompletePopup(viewModel: MyInfo.ViewModel.SignOutCancelCompletedViewModel) {
        self.displayWithAnimation { [weak self] in
            viewModel.show.unwrap {
                let popupContentView = UIView()
                let imageView = UIImageView()
                imageView.image = $0
                imageView.contentMode = .scaleAspectFit
                popupContentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }

                let popupView = TTPopup()
                popupView.configure(title: MyInfo.ViewModel.SignOutCancelCompletedViewModel.title,
                                    resultView: popupContentView,
                                    description: MyInfo.ViewModel.SignOutCancelCompletedViewModel.message,
                                    buttonTitles: [
                                        MyInfo.ViewModel.SignOutCancelCompletedViewModel.confirmOptionText
                                    ])

                popupView.didTapLeftButton {
                    Task {
                        await self?.interactor.didTapSignOutCancelCompleteConfirmButton()
                    }
                }

                popupView.didTapBackground {
                    Task {
                        await self?.interactor.didTapSignOutCancelCompletePopupBackground()
                    }
                }

                self?.signoutCancelCompletePopupView = popupView

                if let signoutCancelCompletePopupView = self?.signoutCancelCompletePopupView {
                    self?.view.addSubview(signoutCancelCompletePopupView)
                }
            }

            viewModel.dismiss.unwrap {
                self?.signoutCancelCompletePopupView?.removeFromSuperview()
                self?.signoutCancelCompletePopupView = nil
            }
        }
    }

    func displayLists(viewModel: MyInfo.ViewModel.Lists) {
        UIView.transition(
            with: self.view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                guard let self = self else {
                    return
                }
                viewModel.items.unwrap {
                    self.myInfoLists = $0
                    self.tableView.reloadData()
                }
            },
            completion: nil
        )
    }

    func displayMyInfo(viewModel: MyInfo.ViewModel.Data) {
        UIView.transition(
            with: self.view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.challengeCountLabel.text = viewModel.challengeTotalCount
                self.myNicknameLabel.text = viewModel.myNickname
                self.partnerNicknameLabel.text = viewModel.partnerNickname
                self.myNameTagView.titleLabel.text = viewModel.myNickname
            },
            completion: nil
        )
    }

    func displayToast(viewModel: MyInfo.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }

    /// 애니메이션과 함께 뷰를 그립니다.
    private func displayWithAnimation(animations: @escaping () -> Void) {
        UIView.transition(
            with: self.view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: animations,
            completion: nil
        )
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension MyInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myInfoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: MyInfoTableViewCell.self, indexPath: indexPath)
        cell.configure(text: self.myInfoLists[indexPath.row].title)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task {
            await self.interactor.didTapMyInfoLists(index: indexPath.row)
        }
    }
}

extension MyInfoViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
