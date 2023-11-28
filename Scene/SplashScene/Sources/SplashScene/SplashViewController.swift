//
//  SplashViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol SplashDisplayLogic: AnyObject {
  func displayUpdatePopup(viewModel: Splash.ViewModel.UpdatePopup)
}

final class SplashViewController: UIViewController {
    var interactor: SplashBusinessLogic
    
    init(interactor: SplashBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    lazy var contentView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 28
        v.addArrangedSubviews(self.appIconImageView, self.appLogoImageView, self.updatePopupView)
        return v
    }()
    
    lazy var appIconImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.app_splash_icon)!
        return v
    }()
    
    lazy var appLogoImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.app_logo)!
        return v
    }()
  
    lazy var updatePopupView: TTPopup = {
      let v = TTPopup()
      v.isHidden = true
      v.didTapLeftButton {
        Task { [weak self] in
          await self?.interactor.didTapUpdateButton()
        }
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
        
        self.view.addSubviews(self.contentView, self.updatePopupView)
        self.view.bringSubviewToFront(self.updatePopupView)
        
        self.contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.appIconImageView.snp.makeConstraints { make in
            make.width.equalTo(122)
            make.height.equalTo(117)
        }
        self.appLogoImageView.snp.makeConstraints { make in
            make.width.equalTo(135)
            make.height.equalTo(23)
        }
      
        self.updatePopupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension SplashViewController: SplashScene {
    
}

// MARK: - Display Logic

extension SplashViewController: SplashDisplayLogic {
  func displayUpdatePopup(viewModel: Splash.ViewModel.UpdatePopup) {
    
    updatePopupView.configure(
      title: viewModel.title,
      resultView: UIImageView(image: viewModel.iconImage),
      description: viewModel.description,
      buttonTitles: viewModel.buttonTitle
    )
    self.updatePopupView.isHidden = false
  }
}
