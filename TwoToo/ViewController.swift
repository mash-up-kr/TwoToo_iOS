//
//  ViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//

import CoreKit
import SceneKit
import UIKit

class ViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fillProportionally
        v.alignment = .center
        v.spacing = 5
        v.addArrangedSubview(self.shortToastTest)
        v.addArrangedSubview(self.longToastTest)
        return v
    }()
    
    lazy var shortToastTest: UIButton = {
        let v = UIButton(type: .custom)
        v.setTitle("토스트 테스트 (short)", for: .normal)
        v.setTitleColor(.black, for: .normal)
        v.addTarget(self, action: #selector(self.didTapShortToastTest), for: .touchUpInside)
        return v
    }()
    
    lazy var longToastTest: UIButton = {
        let v = UIButton(type: .custom)
        v.setTitle("토스트 테스트 (long)", for: .normal)
        v.setTitleColor(.black, for: .normal)
        v.addTarget(self, action: #selector(self.didTapLongToastTest), for: .touchUpInside)
        return v
    }()
    
    @objc func didTapShortToastTest() {
        Task { @MainActor in
            Toast.shared.makeToast("1")
        }
    }
    
    @objc func didTapLongToastTest() {
        Task { @MainActor in
            Toast.shared.makeToast("테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

