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
        v.backgroundColor = .second02
        v.dataSource = self
        v.separatorStyle = .none
        v.isScrollEnabled = false
        return v
    }()
    
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
            await self.interactor.didLoad()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02

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
    func displayLists(viewModel: MyInfo.ViewModel.Lists) {
        viewModel.items.unwrap { [weak self] in
            self?.myInfoLists = $0
            self?.tableView.reloadData()
        }
    }

    func displayMyInfo(viewModel: MyInfo.ViewModel.Data) {
        self.challengeCountLabel.text = viewModel.challengeTotalCount
        self.myNicknameLabel.text = viewModel.myNickname
        self.partnerNicknameLabel.text = viewModel.partnerNickname
        self.myNameTagView.titleLabel.text = viewModel.myNickname
    }
}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myInfoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: MyInfoTableViewCell.self, indexPath: indexPath)
        cell.configure(text: self.myInfoLists[indexPath.row].title)
        return cell
    }
}
