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
            static let message: String = "1~2일 후에 삭제가 완료되어요"
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
        
        /// 회원 탈퇴 취소 팝업
        struct SignOutCancelViewModel {
            var show: (UIImage)?
            var dismiss: ()?
            
            /// 타이틀
            static let title: String = "회원 탈퇴 취소하기"
            /// 메세지
            static let message: String = "회원탈퇴가 이미 요청되었어요\n탈퇴를 취소하실건까요?"
            /// 아니요
            static let noOptionText: String = "아니요"
            /// 탈퇴 취소
            static let SingOutCancelOptionText: String = "탈퇴 취소"
        }
        
        /// 회원 탈퇴 취소 완료 팝업
        struct SignOutCancelCompletedViewModel {
            var show: (UIImage)?
            var dismiss: ()?
            
            /// 타이틀
            static let title: String = "회원 탈퇴 취소 완료"
            /// 메세지
            static let message: String = "회원 탈퇴 요청 취소되었어요"
            /// 확인
            static let confirmOptionText: String = "확인"
        }
    }
}
