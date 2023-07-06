//
//  MainTabBar.swift
//  
//
//  Created by 박건우 on 2023/07/06.
//

import CoreKit
import UIKit

protocol MainTabBarDelegate: AnyObject {
    /// 탭 선택됨
    func didSelectTab(_ tab: Main.ViewModel.MainTab)
}

/// 커스텀 탭바
///
/// 탭바 디자인에 따라 구현하기 위함
final class MainTabBar: UITabBar {
    weak var mainTabBarDelegate: MainTabBarDelegate?
    
    // MARK: - UI
    
    lazy var contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var buttonStackView: UIStackView = {
        let v = UIStackView()
        v.distribution = .fillEqually
        v.addArrangedSubview(self.historyTabButton)
        v.addArrangedSubview(self.homeTabButton)
        v.addArrangedSubview(self.myInfoTabButton)
        return v
    }()
    
    lazy var historyTabButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_history_brown)?.withTintColor(.brown), for: .highlighted)
        v.addAction { [weak self] in
            self?.setHistoryTab()
            self?.mainTabBarDelegate?.didSelectTab(.history)
        }
        return v
    }()
    
    lazy var homeTabButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_home_brown)?.withTintColor(.brown), for: .highlighted)
        v.addAction { [weak self] in
            self?.setHomeTab()
            self?.mainTabBarDelegate?.didSelectTab(.home)
        }
        return v
    }()
    
    lazy var myInfoTabButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_mypage_brown)?.withTintColor(.brown), for: .highlighted)
        v.addAction { [weak self] in
            self?.setMyInfoTab()
            self?.mainTabBarDelegate?.didSelectTab(.myInfo)
        }
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private struct Appearance {
        static let height: CGFloat = 61.0
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = Appearance.height + UIDevice.current.safeAreaBottomHeight
        return sizeThatFits
    }
    
    private func setUI() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.buttonStackView)
        
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.buttonStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(UIDevice.current.safeAreaBottomHeight)
        }
    }
    
    // MARK: - Configure
    
    func setTab(_ tab: Main.ViewModel.MainTab) {
        switch tab {
            case .history:
                self.setHistoryTab()
                
            case .home:
                self.setHomeTab()
                
            case .myInfo:
                self.setMyInfoTab()
        }
    }
    
    private func setHistoryTab() {
        self.contentView.backgroundColor = .second02
        
        self.historyTabButton.setImage(.asset(.icon_history_brown), for: .normal)
        self.homeTabButton.setImage(.asset(.icon_home_pink), for: .normal)
        self.myInfoTabButton.setImage(.asset(.icon_mypage_pink), for: .normal)
    }
    
    private func setHomeTab() {
        self.contentView.backgroundColor = .mainPink
        
        self.historyTabButton.setImage(.asset(.icon_history_yellow), for: .normal)
        self.homeTabButton.setImage(.asset(.icon_home_brown), for: .normal)
        self.myInfoTabButton.setImage(.asset(.icon_mypage_yellow), for: .normal)
    }
    
    private func setMyInfoTab() {
        self.contentView.backgroundColor = .second02
        
        self.historyTabButton.setImage(.asset(.icon_history_pink), for: .normal)
        self.homeTabButton.setImage(.asset(.icon_home_pink), for: .normal)
        self.myInfoTabButton.setImage(.asset(.icon_mypage_brown), for: .normal)
    }
}
