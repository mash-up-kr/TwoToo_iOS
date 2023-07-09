//
//  UIComponentBased.swift
//  
//
//  Created by Eddy on 2023/06/10.
//

import Foundation

/*

 View에서 사용할 때 attribute()는 속성(배경색, 폰트 등) 및 addSubview를 입력할 떄 사용하는 메서드로 사용합니다.
 layout()는 레이아웃을 그려줄 때 사용합니다.

 2가지 메서드는 어떤 View에서도 필요하기 때문에 사용하는 View에서 이 프로토콜을 채택해서 사용하도록 합니다.

 final class TTButton: UIButton, UIComponentBased {
    let title = UILabel()

    func attribute() {
        self.backgroundColor = .black
        self.addSubview(title)
    }

    func layout() {
        title.snp.makeConstraints {
            $0.center.equalToSuperView()
        }
    }
 }

 */

/// 공통 Component에 채택하는 프로토콜
public protocol UIComponentBased {
    func layout()
    func attribute()
}
