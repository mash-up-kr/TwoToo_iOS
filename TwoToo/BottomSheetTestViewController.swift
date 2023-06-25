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
        v.setTitle("touch pass 바텀시트 오픈", for: .normal)
        v.setTitleColor(.systemBlue, for: .normal)
        v.setTitleColor(.blue, for: .normal)
        return v
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button1)
        
        button1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.centerX.equalToSuperview()
        }

        button1.addTarget(self, action: #selector(tap1), for: .touchUpInside)
    }
    
    @objc private func tap1() {
        let bottomSheetViewController = TTBottomSheetViewController(contentViewController: TTBottomSheetCommitViewController())
        present(bottomSheetViewController, animated: true)
    }
}
