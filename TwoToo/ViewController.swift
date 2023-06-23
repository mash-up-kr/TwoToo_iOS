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
    
    lazy var popup: TTPopup = {
        let v = TTPopup(
            title: "Test",
            resultView: self.popupContentView,
            description: "테스트 입니다",
            buttonTitles: ["취소", "그만두기"]
        )
        v.didTapBackground {
            print("배경 클릭")
        }
        v.didTapLeftButton {
            print("왼쪽 버튼 클릭")
        }
        v.didTapRightButton {
            print("오른쪽 버튼 클릭")
        }
        return v
    }()
    
    lazy var popupContentView: UIView = {
        let v = UIView()
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
        
        self.view.addSubview(self.popup)
    }
}

