//
//  SceneDelegate.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//

import CoreKit
import SceneKit
import MainScene
import NudgeSendScene
import ChallengeCertificateScene
import PraiseSendScene
import InvitationSendScene
import InvitationWaitScene
import ChallengeRecommendScene
import UIKit
import NicknameRegistScene
import SplashScene
import LoginScene
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /// 로그인 화면 이동 트리거
    let didTriggerRouteToLoginScene: PassthroughSubject<Void, Never> = .init()
    
    /// 닉네임 설정 화면 이동 트리거
    let didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never> = .init()
    
    /// 초대장 전송 화면 이동 트리거
    let didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never> = .init()
    
    /// 대기 화면 이동 트리거
    let didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never> = .init()
    
    /// 홈 화면 이동 트리거
    let didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> = .init()
    
    var cancellables: Set<AnyCancellable> = []

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.bindTrigger() // 트리거를 바인딩합니다.
        
        self.window = UIWindow(windowScene: windowScene)
        self.window!.makeKeyAndVisible()
        
        let splashScene = SplashSceneFactory().make(with: .init(
            didTriggerRouteToLoginScene: self.didTriggerRouteToLoginScene,
            didTriggerRouteToNickNameScene: self.didTriggerRouteToNickNameScene,
            didTriggerRouteToInvitationSendScene: self.didTriggerRouteToInvitationSendScene,
            didTriggerRouteToInvitationWaitScene: self.didTriggerRouteToInvitationWaitScene,
            didTriggerRouteToHomeScene: self.didTriggerRouteToHomeScene
        ))
        let vc = splashScene.viewController
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
    }
    
    

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    private func bindTrigger() {
        
        self.didTriggerRouteToLoginScene
            .receive(on: DispatchQueue.main)
            .sink {
                let loginScene = LoginSceneFactory().make(with: .init(
                    didTriggerRouteToNickNameScene: self.didTriggerRouteToNickNameScene,
                    didTriggerRouteToInvitationSendScene: self.didTriggerRouteToInvitationSendScene,
                    didTriggerRouteToInvitationWaitScene: self.didTriggerRouteToInvitationWaitScene,
                    didTriggerRouteToHomeScene: self.didTriggerRouteToHomeScene
                ))
                let vc = loginScene.viewController
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                self.window?.layer.add(TransitionOptions(direction: .fade).animation, forKey: kCATransition)
                self.window?.rootViewController = nav
            }
            .store(in: &self.cancellables)
        
        self.didTriggerRouteToNickNameScene
            .receive(on: DispatchQueue.main)
            .sink {
                let nicknameRegistScene = NicknameRegistSceneFactory().make(with: .init(
                    didTriggerRouteToInvitationSendScene: self.didTriggerRouteToInvitationSendScene,
                    didTriggerRouteToHomeScene: self.didTriggerRouteToHomeScene
                ))
                let vc = nicknameRegistScene.viewController
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                self.window?.layer.add(TransitionOptions(direction: .fade).animation, forKey: kCATransition)
                self.window?.rootViewController = nav
            }
            .store(in: &self.cancellables)
        
        self.didTriggerRouteToInvitationSendScene
            .receive(on: DispatchQueue.main)
            .sink {
                let invitationSendScene = InvitationSendSceneFactory().make(with: .init(
                    didTriggerRouteToInvitationWaitScene: self.didTriggerRouteToInvitationWaitScene
                ))
                let vc = invitationSendScene.viewController
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                self.window?.layer.add(TransitionOptions(direction: .fade).animation, forKey: kCATransition)
                self.window?.rootViewController = nav
            }
            .store(in: &self.cancellables)
        
        self.didTriggerRouteToInvitationWaitScene
            .receive(on: DispatchQueue.main)
            .sink {
                let invitationWaitScene = InvitationWaitSceneFactory().make(with: .init(
                    didTriggerRouteToHomeScene: self.didTriggerRouteToHomeScene,
                    invitationLink: $0
                ))
                let vc = invitationWaitScene.viewController
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                self.window?.layer.add(TransitionOptions(direction: .fade).animation, forKey: kCATransition)
                self.window?.rootViewController = nav
            }
            .store(in: &self.cancellables)
        
        self.didTriggerRouteToHomeScene
            .receive(on: DispatchQueue.main)
            .sink {
                let mainScene = MainSceneFactory().make(with: .init())
                let tc = mainScene.viewController
                self.window?.layer.add(TransitionOptions(direction: .fade).animation, forKey: kCATransition)
                self.window?.rootViewController = tc
            }
            .store(in: &self.cancellables)
    }
}

