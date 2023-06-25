//
//  BottomSheetTestViewController.swift
//  TwoToo
//
//  Created by Julia on 2023/06/23.
//

import CoreKit
import SceneKit
import UIKit
import DesignSystem

final class BottomSheetTestViewController: UIViewController {
    
    private let button1: UIButton = {
        let v = UIButton()
        v.setTitle("인증하기 바텀시트 오픈", for: .normal)
        v.setTitleColor(.systemBlue, for: .normal)
        v.setTitleColor(.blue, for: .normal)
        return v
    }()
    
    private let button2: UIButton = {
        let v = UIButton()
        v.setTitle("칭찬하기 바텀시트 오픈", for: .normal)
        v.setTitleColor(.systemBlue, for: .normal)
        v.setTitleColor(.blue, for: .normal)
        return v
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button1)
        view.addSubview(button2)
        
        button1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        button2.snp.makeConstraints {
            $0.top.equalTo(self.button1.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        button1.addTarget(self, action: #selector(tap1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tap2), for: .touchUpInside)
    }
    
    @objc private func tap1() {
        let bottomSheetViewController = TTBottomSheetViewController(contentViewController: TTBottomSheetCommitViewController())
        present(bottomSheetViewController, animated: true)
    }
    
    @objc private func tap2() {
        let bottomSheetViewController = TTBottomSheetViewController(contentViewController: TTBottomSheetPushViewController(title: "오늘의 칭찬 한마디",
                                                                                                                           placeHolder: "(최대 20자) 칭찬 문구를 입력해주세요. \n예) 오늘도 잘해냈어, 앞으로도 파이팅",
                                                                                                                           description: "* 한번 등록한 문구는 수정이 불가해요"))
        present(bottomSheetViewController, animated: true)
    }
}
