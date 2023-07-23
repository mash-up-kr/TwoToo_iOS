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
        v.backgroundColor = .grey200
        return v
    }()
    
    lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.text = "내 이름"
        return v
    }()
    
    lazy var partnerLabel: UILabel = {
        let v = UILabel()
        v.text = "상대방 이름"
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
        
//        self.view.backgroundColor = .mainPink
//        self.view.addSubview(self.tagView)
//        self.view.addSubview(self.tag2View)
//
//        self.tagView.snp.makeConstraints { make in
//            make.width.equalTo(42)
//            make.height.equalTo(24)
//            make.centerX.centerY.equalToSuperview()
//        }
//        
//        self.tag2View.snp.makeConstraints { make in
//            make.top.equalTo(self.tagView.snp.bottom).offset(20)
//            make.width.equalTo(50)
//            make.height.equalTo(30)
//            make.centerX.equalToSuperview()
//        }
//        
//            
    }
}

