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
        let v = TTNavigationBar(title: "Twotoo",
                                rightButtonImage: .asset(.icon_cancel))
        v.delegate = self
        return v
    }()
    
    lazy var navi2View: TTNavigationBar = {
        let v = TTNavigationBar(title: "마이페이지",
                                rightButtonImage: .asset(.icon_info))
        v.delegate = self
        return v
    }()

    lazy var navi3View: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: "상세",
                                      leftButtonImage: .asset(.icon_back),
                                      rightButtonImage: .asset(.icon_more))
        v.delegate = self
        return v
    }()

    lazy var navi4View: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: nil,
                                      leftButtonImage: .asset(.icon_back),
                                      rightButtonImage: nil)
        v.delegate = self
        return v
    }()

    lazy var navi5View: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: "Hello",
                                      leftButtonImage: .asset(.icon_more),
                                      rightButtonImage: nil)
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
    public func didTapDetailLeftButton() {
        print("Detail More button")
    }
    
    public func didTapDetailRightButton() {
        print("Detail Right button")
    }
}

extension NaviTestViewController: TTNavigationDetailBarDelegate{
    public func tapBackButton() {
        print("Back button")
    }
    
    public func didTaprightButton() {
        print("Info button")
    }
}
