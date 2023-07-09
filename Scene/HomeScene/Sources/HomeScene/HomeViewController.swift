//
//  HomeViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol HomeDisplayLogic: AnyObject {}

final class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic
    
    init(interactor: HomeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    lazy var progressBar: TTProgressBar = {
        let v = TTProgressBar()
        v.layer.cornerRadius = 15
        v.configureNickname(my: "공주", partner: "왕자")
        v.configurePercent(my: 30, partner: 70)
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.progressBar)
        
        self.progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(24)
            make.width.equalToSuperview().multipliedBy(0.55)
            make.height.equalTo(62)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension HomeViewController: HomeScene {
    
}

// MARK: - Display Logic

extension HomeViewController: HomeDisplayLogic {
    
}
