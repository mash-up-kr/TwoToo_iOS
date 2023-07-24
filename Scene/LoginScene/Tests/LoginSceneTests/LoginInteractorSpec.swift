import Combine
import Foundation
import Quick
import Nimble
@testable import LoginScene

final class LoginInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: LoginInteractor!
        var presenter: LoginPresenterMock!
        var worker: LoginWorkerMock!
        var router: LoginRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await LoginPresenterMock()
            router = await LoginRouterMock()
            worker = LoginWorkerMock()
            
            interactor = LoginInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>(),
                didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>(),
                didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>(),
                didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>()
            )
            
            cancellables = []
        }
        
        describe("진입") {
            describe("온보딩을 보지 않았다.") {
                beforeEach {
                    worker.isCheckedOnboardingResult = false
                }
                
                context("첫 진입 시") {
                    beforeEach {
                        await interactor.didLoad()
                    }
                    
                    it("온보딩을 보여준다.") {
                        let isPresentOnboardingCalled = await presenter.isPresentOnboardingCalled
                        expect(isPresentOnboardingCalled).to(beTrue())
                    }
                }
            }
            
            describe("온보딩을 보았다.") {
                beforeEach {
                    worker.isCheckedOnboardingResult = true
                }
                
                context("첫 진입 시") {
                    beforeEach {
                        await interactor.didLoad()
                    }
                    
                    it("로그인을 보여준다.") {
                        let isPresentLoginCalled = await presenter.isPresentLoginCalled
                        expect(isPresentLoginCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("로그인") {
            describe("카카오가 설치되어있다.") {
                beforeEach {
                    worker.isKakaoTalkAvailableResult = true
                }
                
                context("카카오 로그인 버튼 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapKakaoLoginButton()
                    }
                    
                    it("카카오톡 로그인 요청을 보낸다.") {
                        expect(worker.isLoginWithKakaoTalkCalled).to(beTrue())
                    }
                }
                
                describe("카카오 계정 로그인 결과가 실패다.") {
                    beforeEach {
                        worker.loginWithKakaoAccountResult = .failure(NSError(domain: "Test", code: 1))
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        beforeEach {
                            await interactor.didTapKakaoLoginButton()
                        }
                        
                        it("카카오 로그인 오류를 보여준다.") {
                            let isPresentKakaoLoginErrorCalled = await presenter.isPresentKakaoLoginErrorCalled
                            expect(isPresentKakaoLoginErrorCalled).to(beTrue())
                        }
                    }
                }
                
                describe("카카오톡 로그인 결과가 닉네임 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoTalkResult = .success(.nickname)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToNickNameSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "닉네임 화면 이동 트리거")

                            interactor.didTriggerRouteToNickNameScene
                                .sink { _ in
                                    didTriggerRouteToNickNameSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }
                        
                        it("닉네임 화면으로 이동한다.") {
                            expect(didTriggerRouteToNickNameSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("카카오톡 로그인 결과가 초대 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoTalkResult = .success(.invitationSend)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToInvitationSendSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "초대장 전송 화면 이동 트리거")

                            interactor.didTriggerRouteToInvitationSendScene
                                .sink { _ in
                                    didTriggerRouteToInvitationSendSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }

                        it("초대장 전송 화면으로 이동한다.") {
                            expect(didTriggerRouteToInvitationSendSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("카카오톡 로그인 결과가 대기 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoTalkResult = .success(.invitationWait)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToInvitationWaitSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "대기 화면 이동 트리거")

                            interactor.didTriggerRouteToInvitationWaitScene
                                .sink { _ in
                                    didTriggerRouteToInvitationWaitSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }

                        it("대기 화면으로 이동한다.") {
                            expect(didTriggerRouteToInvitationWaitSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("카카오톡 로그인 결과가 홈 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoTalkResult = .success(.home)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToHomeSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "홈 화면 이동 트리거")

                            interactor.didTriggerRouteToHomeScene
                                .sink { _ in
                                    didTriggerRouteToHomeSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }

                        it("홈 화면으로 이동한다.") {
                            expect(didTriggerRouteToHomeSceneValue).to(beVoid())
                        }
                    }
                }
            }
            
            describe("카카오가 설치되어있지 않다.") {
                beforeEach {
                    worker.isKakaoTalkAvailableResult = false
                }
                
                context("카카오 로그인 버튼 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapKakaoLoginButton()
                    }
                    
                    it("카카오 계졍 로그인 요청을 보낸다.") {
                        expect(worker.isLoginWithKakaoAccountCalled).to(beTrue())
                    }
                }
                
                describe("카카오톡 로그인 결과가 실패다.") {
                    beforeEach {
                        worker.loginWithKakaoTalkResult = .failure(NSError(domain: "Test", code: 1))
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        beforeEach {
                            await interactor.didTapKakaoLoginButton()
                        }
                        
                        it("카카오 로그인 오류를 보여준다.") {
                            let isPresentKakaoLoginErrorCalled = await presenter.isPresentKakaoLoginErrorCalled
                            expect(isPresentKakaoLoginErrorCalled).to(beTrue())
                        }
                    }
                }
                
                describe("카카오 계정 로그인 결과가 닉네임 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoAccountResult = .success(.nickname)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToNickNameSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "닉네임 화면 이동 트리거")

                            interactor.didTriggerRouteToNickNameScene
                                .sink { _ in
                                    didTriggerRouteToNickNameSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }
                        
                        it("닉네임 화면으로 이동한다.") {
                            expect(didTriggerRouteToNickNameSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("카카오 계정 로그인 결과가 초대 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoAccountResult = .success(.invitationSend)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToInvitationSendSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "초대장 전송 화면 이동 트리거")

                            interactor.didTriggerRouteToInvitationSendScene
                                .sink { _ in
                                    didTriggerRouteToInvitationSendSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }

                        it("초대장 전송 화면으로 이동한다.") {
                            expect(didTriggerRouteToInvitationSendSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("카카오 계정 로그인 결과가 대기 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoAccountResult = .success(.invitationWait)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToInvitationWaitSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "대기 화면 이동 트리거")

                            interactor.didTriggerRouteToInvitationWaitScene
                                .sink { _ in
                                    didTriggerRouteToInvitationWaitSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }

                        it("대기 화면으로 이동한다.") {
                            expect(didTriggerRouteToInvitationWaitSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("카카오 계정 로그인 결과가 홈 상태이다.") {
                    beforeEach {
                        worker.loginWithKakaoAccountResult = .success(.home)
                    }
                    
                    context("카카오 로그인 버튼 눌렀을 때") {
                        var didTriggerRouteToHomeSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "홈 화면 이동 트리거")

                            interactor.didTriggerRouteToHomeScene
                                .sink { _ in
                                    didTriggerRouteToHomeSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapKakaoLoginButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }

                        it("홈 화면으로 이동한다.") {
                            expect(didTriggerRouteToHomeSceneValue).to(beVoid())
                        }
                    }
                }
            }
            
            context("애플 로그인 버튼 눌렀을 때") {
                beforeEach {
                    await interactor.didTapAppleLoginButton()
                }
                
                it("애플 로그인 요청을 보낸다.") {
                    expect(worker.isLoginWithAppleCalled).to(beTrue())
                }
            }
            
            describe("애플 로그인 결과가 닉네임 상태이다.") {
                beforeEach {
                    worker.loginWithAppleResult = .success(.nickname)
                }
                
                context("애플 로그인 버튼 눌렀을 때") {
                    var didTriggerRouteToNickNameSceneValue: Void? = nil

                    beforeEach {
                        let expectation = self.expectation(description: "닉네임 화면 이동 트리거")

                        interactor.didTriggerRouteToNickNameScene
                            .sink { _ in
                                didTriggerRouteToNickNameSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)

                        await interactor.didTapAppleLoginButton()

                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("닉네임 화면으로 이동한다.") {
                        expect(didTriggerRouteToNickNameSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("애플 로그인 결과가 초대 상태이다.") {
                beforeEach {
                    worker.loginWithAppleResult = .success(.invitationSend)
                }
                
                context("애플 로그인 버튼 눌렀을 때") {
                    var didTriggerRouteToInvitationSendSceneValue: Void? = nil

                    beforeEach {
                        let expectation = self.expectation(description: "초대장 전송 화면 이동 트리거")

                        interactor.didTriggerRouteToInvitationSendScene
                            .sink { _ in
                                didTriggerRouteToInvitationSendSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)

                        await interactor.didTapAppleLoginButton()

                        await self.fulfillment(of: [expectation], timeout: 3)
                    }

                    it("초대장 전송 화면으로 이동한다.") {
                        expect(didTriggerRouteToInvitationSendSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("애플 로그인 결과가 대기 상태이다.") {
                beforeEach {
                    worker.loginWithAppleResult = .success(.invitationWait)
                }
                
                context("애플 로그인 버튼 눌렀을 때") {
                    var didTriggerRouteToInvitationWaitSceneValue: Void? = nil

                    beforeEach {
                        let expectation = self.expectation(description: "대기 화면 이동 트리거")

                        interactor.didTriggerRouteToInvitationWaitScene
                            .sink { _ in
                                didTriggerRouteToInvitationWaitSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)

                        await interactor.didTapAppleLoginButton()

                        await self.fulfillment(of: [expectation], timeout: 3)
                    }

                    it("대기 화면으로 이동한다.") {
                        expect(didTriggerRouteToInvitationWaitSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("애플 로그인 결과가 홈 상태이다.") {
                beforeEach {
                    worker.loginWithAppleResult = .success(.home)
                }
                
                context("애플 로그인 버튼 눌렀을 때") {
                    var didTriggerRouteToHomeSceneValue: Void? = nil

                    beforeEach {
                        let expectation = self.expectation(description: "홈 화면 이동 트리거")

                        interactor.didTriggerRouteToHomeScene
                            .sink { _ in
                                didTriggerRouteToHomeSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)

                        await interactor.didTapAppleLoginButton()

                        await self.fulfillment(of: [expectation], timeout: 3)
                    }

                    it("홈 화면으로 이동한다.") {
                        expect(didTriggerRouteToHomeSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("애플 로그인 결과가 실패다.") {
                beforeEach {
                    worker.loginWithAppleResult = .failure(NSError(domain: "Test", code: 1))
                }
                
                context("애플 로그인 버튼 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapAppleLoginButton()
                    }
                    
                    it("애플 로그인 오류를 보여준다.") {
                        let isPresentAppleLoginErrorCalled = await presenter.isPresentAppleLoginErrorCalled
                        expect(isPresentAppleLoginErrorCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("온보딩") {
            describe("3번째 인덱스의 온보딩 페이지이다.") {
                context("온보딩을 스와이프 했을 때") {
                    beforeEach {
                        await interactor.didSwipeOnboarding(index: 3)
                    }
                    
                    it("확인함으로 온보딩 업데이트 요청을 한다.") {
                        expect(worker.lastIsCheckedOnboarding).to(beTrue())
                    }
                    
                    it("로그인을 보여준다.") {
                        let isPresentLoginCalled = await presenter.isPresentLoginCalled
                        expect(isPresentLoginCalled).to(beTrue())
                    }
                }
            }
            
            describe("3번째 인덱스의 온보딩 페이지가 아니다.") {
                context("온보딩을 스와이프 했을 때") {
                    beforeEach {
                        await interactor.didSwipeOnboarding(index: 2)
                    }
                    
                    it("확인함으로 온보딩 업데이트 요청을 하지 않는다.") {
                        expect(worker.lastIsCheckedOnboarding).to(beNil())
                    }
                    
                    it("로그인을 보여주지 않는다.") {
                        let isPresentLoginCalled = await presenter.isPresentLoginCalled
                        expect(isPresentLoginCalled).to(beFalse())
                    }
                }
            }
        }
    }
}

class LoginPresenterMock: LoginPresentationLogic {
    
    var isPresentOnboardingCalled = false
    var isPresentLoginCalled = false
    var isPresentKakaoLoginErrorCalled = false
    var isPresentAppleLoginErrorCalled = false
    
    var lastKakaoLoginError: Error?
    var lastAppleLoginError: Error?
    
    func presentOnboarding() {
        self.isPresentOnboardingCalled = true
    }
    
    func presentLogin() {
        self.isPresentLoginCalled = true
    }
    
    func presentKakaoLoginError(error: Error) {
        self.isPresentKakaoLoginErrorCalled = true
        self.lastKakaoLoginError = error
    }
    
    func presentAppleLoginError(error: Error) {
        self.isPresentAppleLoginErrorCalled = true
        self.lastAppleLoginError = error
    }
}

class LoginWorkerMock: LoginWorkerProtocol {
    
    var isIsCheckedOnboardingCalled = false
    var isIsKakaoTalkAvailableCalled = false
    var isLoginWithKakaoTalkCalled = false
    var isLoginWithKakaoAccountCalled = false
    var isLoginWithAppleCalled = false
    
    var lastIsCheckedOnboarding: Bool?
    
    var isCheckedOnboardingResult: Bool?
    var isKakaoTalkAvailableResult: Bool?
    var loginWithKakaoTalkResult: Result<Login.Model.UserState, Error>?
    var loginWithKakaoAccountResult: Result<Login.Model.UserState, Error>?
    var loginWithAppleResult: Result<Login.Model.UserState, Error>?
    
    var isCheckedOnboarding: Bool {
        get {
            self.isIsCheckedOnboardingCalled = true
            return self.isCheckedOnboardingResult ?? false
        }
        set {
            self.lastIsCheckedOnboarding = newValue
        }
    }
    
    var isKakaoTalkAvailable: Bool {
        self.isIsKakaoTalkAvailableCalled = true
        return self.isKakaoTalkAvailableResult ?? false
    }
    
    func loginWithKakaoTalk() async throws -> Login.Model.UserState {
        self.isLoginWithKakaoTalkCalled = true
        
        switch self.loginWithKakaoTalkResult {
            case .success(let state):
                return state

            case .failure(let error):
                throw error

            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    func loginWithKakaoAccount() async throws -> Login.Model.UserState {
        self.isLoginWithKakaoAccountCalled = true
        
        switch self.loginWithKakaoAccountResult {
            case .success(let state):
                return state

            case .failure(let error):
                throw error

            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    func loginWithApple() async throws -> Login.Model.UserState {
        self.isLoginWithAppleCalled = true
        
        switch self.loginWithAppleResult {
            case .success(let state):
                return state

            case .failure(let error):
                throw error

            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
}

class LoginRouterMock: LoginRoutingLogic {
    
}
