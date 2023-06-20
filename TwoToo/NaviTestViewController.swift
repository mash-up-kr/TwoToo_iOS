//
//  NaviTestViewController.swift
//  TwoToo
//
//  Created by Julia on 2023/06/20.
//

import CoreKit
import SceneKit
import UIKit
import DesignSystem

public class NaviTestViewController: UIViewController {

    lazy var naviView: TTNavigationBar = {
        let v = TTNavigationBar(title: "TwoToo",
                                infoButtonIsHidden: true)
        v.delegate = self
        return v
    }()
    
    lazy var navi2View: TTNavigationBar = {
        let v = TTNavigationBar(title: "마이페이지",
                                infoButtonIsHidden: false)
        v.delegate = self
        return v
    }()
    
    lazy var navi3View: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: nil,
                                      moreButtonIsHidden: true)
        v.delegate = self
        return v
    }()
    
    lazy var navi4View: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: "상세페이지",
                                      moreButtonIsHidden: true)
        v.delegate = self
        return v
    }()
    
    lazy var navi5View: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: "상세페이지2",
                                      moreButtonIsHidden: false)
        v.delegate = self
        return v
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.naviView)
        self.view.addSubview(self.navi2View)
        self.view.addSubview(self.navi3View)
        self.view.addSubview(self.navi4View)
        self.view.addSubview(self.navi5View)

        self.naviView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        self.navi2View.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        self.navi3View.snp.makeConstraints { make in
            make.top.equalTo(self.navi2View.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        self.navi4View.snp.makeConstraints { make in
            make.top.equalTo(self.navi3View.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        self.navi5View.snp.makeConstraints { make in
            make.top.equalTo(self.navi4View.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
    }
}


extension NaviTestViewController: TTNavigationBarDelegate{
    public func didTapDetailMoreButton() {
        print("Detail More button")
    }
    
    public func didTapDetailBackButton() {
        print("Detail Right button")
    }
}

extension NaviTestViewController: TTNavigationDetailBarDelegate{
    public func tapBackButton() {
        print("Back button")
    }
    
    public func didTapInfoButton() {
        print("Info button")
    }
}
