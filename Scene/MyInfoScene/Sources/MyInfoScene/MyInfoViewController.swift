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
    func displayMyInfo(viewModel: MyInfo.ViewModel.MyInfo)
}

final class MyInfoViewController: UIViewController {
    var interactor: MyInfoBusinessLogic
    
    var myInfoItems: [MyInfo.ViewModel.MyInfo.Item] = []
    
    // MARK: - UI
    
    private lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "마이페이지", rightButtonImage: .asset(.icon_info))
        return v
    }()
    
    private lazy var mainImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_nicknam_my)
        return v
    }()
    
    private lazy var coupleLabel: UILabel = {
        let v = UILabel()
        v.text = "공주 ❤️ 왕자"
        v.textColor = .mainCoral
        v.font = .body3
        return v
    }()
    
    private lazy var challengeCountLabel: UILabel = {
        let v = UILabel()
        v.textColor = .mainCoral
        v.font = .body3
        v.text = "1번째 꽃 피우는중"
        return v
    }()
    
    private lazy var myNameTagView: TTTagView = {
        let v = TTTagView(textColor: .primary, fontSize: .body2, cornerRadius: 15)
        v.titleLabel.text = "공주"
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
        
        self.view.addSubviews(
            self.navigationBar, self.mainImageView,
            self.coupleLabel, self.challengeCountLabel,
            self.myNameTagView, self.separator,
            self.tableView
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
        
        self.coupleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.mainImageView.snp.bottom).offset(19)
            make.centerX.equalTo(self.mainImageView.snp.centerX)
        }
        
        self.challengeCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.coupleLabel.snp.bottom).offset(10)
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

// MARK: - Trigger by Parent Scene

extension MyInfoViewController: MyInfoScene {
    
}


// MARK: - Display Logic

extension MyInfoViewController: MyInfoDisplayLogic {
    func displayMyInfo(viewModel: MyInfo.ViewModel.MyInfo) {
        viewModel.items.unwrap { [weak self] in
            self?.myInfoItems = $0
            self?.tableView.reloadData()
        }
    }
}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myInfoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: MyInfoTableViewCell.self, indexPath: indexPath)
        cell.configure(text: self.myInfoItems[indexPath.row].title)
        return cell
    }
}
