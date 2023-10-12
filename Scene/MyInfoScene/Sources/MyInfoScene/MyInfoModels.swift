//
//  MyInfoModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum MyInfo {
    
    // MARK: Entity
    
    enum Model {
        struct Data {
            var myNickname: String
            var partnerNickname: String
            var challengeTotalCount: String?
        }

        enum SocialLoginStatus: String, Equatable {
            /// 카카오 로그인
            case kakaoLogin = "Kakao"
            /// 애플 로그인
            case appleLogin = "Apple"
        }
    }
    
    enum ViewModel {
        struct Lists {
            var items: [Item]?
            
            struct Item {
                var title: String
            }
        }

        struct Data {
            var myNickname: String
            var partnerNickname: String
            var challengeTotalCount: String?
        }

        struct Toast {
            var message: String?
        }

        /// 회원 탈퇴 팝업
        struct SignOutViewModel {
            var show: (UIImage)?
            var dismiss: ()?

            /// 타이틀
            static let title: String = "회원 탈퇴하기"
            /// 메세지
            static let message: String = "파트너도 같이 삭제 되어요."
            /// 취소
            static let cancelOptionText: String = "취소"
            /// 탈퇴하기 옵션
            static let signOutOptionText: String = "탈퇴하기"
        }

        /// 회원 탈퇴 완료 팝업
        struct SignOutCompletedViewModel {
            var show: (UIImage)?
            var dismiss: ()?

            /// 타이틀
            static let title: String = "회원 탈퇴 완료"
            /// 메세지
            static let message: String = "아쉽지만 다음에 또 만나요!"
            /// 확인
            static let confirmOptionText: String = "확인"

        }
    }
}
