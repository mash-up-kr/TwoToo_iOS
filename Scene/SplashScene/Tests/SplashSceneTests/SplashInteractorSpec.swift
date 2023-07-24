import Combine
import Foundation
import Quick
import Nimble
@testable import SplashScene

final class SplashInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: SplashInteractor!
        var presenter: SplashPresenterMock!
        var worker: SplashWorkerMock!
        var router: SplashRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await SplashPresenterMock()
            router = await SplashRouterMock()
            worker = SplashWorkerMock()
            
            interactor = SplashInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>(),
                didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>(),
                didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>(),
                didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>(),
                didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>()
            )
            
            cancellables = []
        }
        
        describe("진입") {
            context("첫 진입하였을 때") {
                beforeEach {
                    await interactor.didLoad()
                }
                
                it("유저 상태를 조회한다.") {
                    expect(worker.isFetchUserStateCalled).to(beTrue())
                }
            }
            
            describe("유저 상태 조회 결과가 실패이다.") {
                beforeEach {
                    worker.fetchUserStateResult = .failure(NSError(domain: "Test", code: 1))
                }
                
                context("첫 진입하였을 때") {
                    var didTriggerRouteToLoginSceneValue: Void? = nil
                    
                    beforeEach {
                        let expectation = self.expectation(description: "로그인 화면 이동 트리거")
                        
                        interactor.didTriggerRouteToLoginScene
                            .sink { _ in
                                didTriggerRouteToLoginSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)
                        
                        await interactor.didLoad()
                        
                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("로그인 화면으로 이동한다.") {
                        expect(didTriggerRouteToLoginSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("유저 상태 조회 결과가 로그인이다.") {
                beforeEach {
                    worker.fetchUserStateResult = .success(.login)
                }
                
                context("첫 진입하였을 때") {
                    var didTriggerRouteToLoginSceneValue: Void? = nil
                    
                    beforeEach {
                        let expectation = self.expectation(description: "로그인 화면 이동 트리거")
                        
                        interactor.didTriggerRouteToLoginScene
                            .sink { _ in
                                didTriggerRouteToLoginSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)
                        
                        await interactor.didLoad()
                        
                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("로그인 화면으로 이동한다.") {
                        expect(didTriggerRouteToLoginSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("유저 상태 조회 결과가 닉네임 상태이다.") {
                beforeEach {
                    worker.fetchUserStateResult = .success(.nickname)
                }
                
                context("첫 진입하였을 때") {
                    var didTriggerRouteToNickNameSceneValue: Void? = nil
                    
                    beforeEach {
                        let expectation = self.expectation(description: "닉네임 화면 이동 트리거")
                        
                        interactor.didTriggerRouteToNickNameScene
                            .sink { _ in
                                didTriggerRouteToNickNameSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)
                        
                        await interactor.didLoad()
                        
                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("닉네임 화면으로 이동한다.") {
                        expect(didTriggerRouteToNickNameSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("유저 상태 조회 결과가 초대 상태이다.") {
                beforeEach {
                    worker.fetchUserStateResult = .success(.invitationSend)
                }
                
                context("첫 진입하였을 때") {
                    var didTriggerRouteToInvitationSendSceneValue: Void? = nil
                    
                    beforeEach {
                        let expectation = self.expectation(description: "초대장 전송 화면 이동 트리거")
                        
                        interactor.didTriggerRouteToInvitationSendScene
                            .sink { _ in
                                didTriggerRouteToInvitationSendSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)
                        
                        await interactor.didLoad()
                        
                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("초대장 전송 화면으로 이동한다.") {
                        expect(didTriggerRouteToInvitationSendSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("유저 상태 조회 결과가 대기 상태이다.") {
                beforeEach {
                    worker.fetchUserStateResult = .success(.invitationWait)
                }
                
                context("첫 진입하였을 때") {
                    var didTriggerRouteToInvitationWaitSceneValue: Void? = nil
                    
                    beforeEach {
                        let expectation = self.expectation(description: "대기 화면 이동 트리거")
                        
                        interactor.didTriggerRouteToInvitationWaitScene
                            .sink { _ in
                                didTriggerRouteToInvitationWaitSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)
                        
                        await interactor.didLoad()
                        
                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("대기 화면으로 이동한다.") {
                        expect(didTriggerRouteToInvitationWaitSceneValue).to(beVoid())
                    }
                }
            }
            
            describe("유저 상태 조회 결과가 홈 상태이다.") {
                beforeEach {
                    worker.fetchUserStateResult = .success(.home)
                }
                
                context("첫 진입하였을 때") {
                    var didTriggerRouteToHomeSceneValue: Void? = nil
                    
                    beforeEach {
                        let expectation = self.expectation(description: "홈 화면 이동 트리거")
                        
                        interactor.didTriggerRouteToHomeScene
                            .sink { _ in
                                didTriggerRouteToHomeSceneValue = ()
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)
                        
                        await interactor.didLoad()
                        
                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("홈 화면으로 이동한다.") {
                        expect(didTriggerRouteToHomeSceneValue).to(beVoid())
                    }
                }
            }
        }
    }
}

class SplashPresenterMock: SplashPresentationLogic {
    
}

class SplashWorkerMock: SplashWorkerProtocol {
    
    var isFetchUserStateCalled = false
    var fetchUserStateResult: Result<Splash.Model.UserState, Error>?
    
    func fetchUserState() async throws -> Splash.Model.UserState {
        self.isFetchUserStateCalled = true
        
        switch self.fetchUserStateResult {
            case .success(let state):
                return state
                
            case .failure(let error):
                throw error
                
            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    
}

class SplashRouterMock: SplashRoutingLogic {
    
}
