import Combine
import Foundation
import Quick
import Nimble
@testable import NicknameRegistScene

final class NicknameRegistInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: NicknameRegistInteractor!
        var presenter: NicknameRegistPresenterMock!
        var worker: NicknameRegistWorkerMock!
        var router: NicknameRegistRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await NicknameRegistPresenterMock()
            router = await NicknameRegistRouterMock()
            worker = NicknameRegistWorkerMock()
            
            interactor = NicknameRegistInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>(),
                didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>()
            )
            
            cancellables = []
        }
        
        describe("진입") {
            describe("초대 유저가 존재한다.") {
                beforeEach {
                    worker.invitedUserResult = .init(name: "Test")
                }
                
                context("첫 진입 시") {
                    beforeEach {
                        await interactor.didLoad()
                    }
                    
                    it("초대 유저를 보여준다.") {
                        let isPresentInvitedUserCalled = await presenter.isPresentInvitedUserCalled
                        expect(isPresentInvitedUserCalled).to(beTrue())
                    }
                }
            }
            
            describe("초대 유저가 존재하지 않는다.") {
                beforeEach {
                    worker.invitedUserResult = nil
                }
                
                context("첫 진입 시") {
                    beforeEach {
                        await interactor.didLoad()
                    }
                    
                    // none
                }
            }
        }
        
        describe("닉네임 입력") {
            context("닉네임이 입력되었을 때") {
                beforeEach {
                    await interactor.didEnterNickname(text: "Test")
                }
                
                it("입력된 닉네임으로 닉네임 데이터를 업데이트한다.") {
                    expect(interactor.nickname).to(equal("Test"))
                }
            }
            
            describe("닉네임이 비어있다.") {
                beforeEach {
                    interactor.nickname = ""
                }
                
                context("닉네임 데이터가 업데이트 되었을 때") {
                    beforeEach {
                        await interactor.didUpdateNickname()
                    }
                    
                    it("확인 버튼을 비활성화하여 보여준다.") {
                        let isPresentDisabledConfirmButtonCalled = await presenter.isPresentDisabledConfirmButtonCalled
                        expect(isPresentDisabledConfirmButtonCalled).to(beTrue())
                    }
                }
            }
            
            describe("닉네임이 입력되었다.") {
                beforeEach {
                    interactor.nickname = "Test"
                }
                
                context("닉네임 데이터가 업데이트 되었을 때") {
                    beforeEach {
                        await interactor.didUpdateNickname()
                    }
                    
                    it("확인 버튼을 활성화하여 보여준다.") {
                        let isPresentEnabledConfirmButtonCalled = await presenter.isPresentEnabledConfirmButtonCalled
                        expect(isPresentEnabledConfirmButtonCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("닉네임 설정 & 매칭") {
            describe("닉네임이 입력되었다") {
                beforeEach {
                    interactor.nickname = "Test"
                }
                
                describe("초대 유저가 존재하지 않는다") {
                    beforeEach {
                        worker.invitedUserResult = nil
                    }
                    
                    context("확인 버튼을 눌렀을 때") {
                        beforeEach {
                            await interactor.didTapConfirmButton()
                        }
                        
                        it("입력된 닉네임으로 닉네임 설정 요청을 한다.") {
                            expect(worker.lastNickname).to(equal("Test"))
                            expect(worker.isRequestSetNicknameCalled).to(beTrue())
                        }
                    }
                    
                    describe("닉네임 설정 요청 결과가 성공이다.") {
                        beforeEach {
                            worker.requestSetNicknameResult = true
                        }
                        
                        context("확인 버튼을 눌렀을 때") {
                            var didTriggerRouteToInvitationSendSceneValue: Void? = nil
                            
                            beforeEach {
                                let expectation = self.expectation(description: "초대장 전송 화면 이동 트리거")

                                interactor.didTriggerRouteToInvitationSendScene
                                    .sink { _ in
                                        didTriggerRouteToInvitationSendSceneValue = ()
                                        expectation.fulfill()
                                    }
                                    .store(in: &cancellables)

                                await interactor.didTapConfirmButton()

                                await self.fulfillment(of: [expectation], timeout: 3)
                            }

                            it("초대장 전송 화면으로 이동한다.") {
                                expect(didTriggerRouteToInvitationSendSceneValue).to(beVoid())
                            }
                        }
                    }
                }
                
                describe("닉네임 설정 요청 결과가 실패이다.") {
                    beforeEach {
                        worker.requestSetNicknameResult = false
                    }
                    
                    context("확인 버튼을 눌렀을 때") {
                        beforeEach {
                            await interactor.didTapConfirmButton()
                        }
                        
                        it("닉네임 설정 오류를 보여준다.") {
                            let isPresentNicknameErrorCalled = await presenter.isPresentNicknameErrorCalled
                            expect(isPresentNicknameErrorCalled).to(beTrue())
                        }
                    }
                }
                
                describe("초대 유저가 존재한다.") {
                    beforeEach {
                        worker.invitedUserResult = .init(name: "TestUser")
                    }
                    
                    describe("닉네임 설정 요청 결과가 성공이다.") {
                        beforeEach {
                            worker.requestSetNicknameResult = true
                        }
                        
                        context("확인 버튼을 눌렀을 때") {
                            beforeEach {
                                await interactor.didTapConfirmButton()
                            }
                            
                            it("매칭 요청을 한다.") {
                                expect(worker.isRequestMatchingCalled).to(beTrue())
                            }
                        }
                        
                        describe("매칭 요청 결과가 성공이다.") {
                            beforeEach {
                                worker.requestMatchingResult = true
                            }
                            
                            context("확인 버튼을 눌렀을 때") {
                                var didTriggerRouteToHomeSceneValue: Void? = nil

                                beforeEach {
                                    let expectation = self.expectation(description: "홈 화면 이동 트리거")

                                    interactor.didTriggerRouteToHomeScene
                                        .sink { _ in
                                            didTriggerRouteToHomeSceneValue = ()
                                            expectation.fulfill()
                                        }
                                        .store(in: &cancellables)

                                    await interactor.didTapConfirmButton()

                                    await self.fulfillment(of: [expectation], timeout: 3)
                                }

                                it("홈 화면으로 이동한다.") {
                                    expect(didTriggerRouteToHomeSceneValue).to(beVoid())
                                }
                            }
                        }
                        
                        describe("매칭 요청 결과가 실패이다.") {
                            beforeEach {
                                worker.requestMatchingResult = false
                            }
                            
                            context("확인 버튼을 눌렀을 때") {
                                beforeEach {
                                    await interactor.didTapConfirmButton()
                                }
                                
                                it("매칭 오류를 보여준다.") {
                                    let isPresentMatchingErrorCalled = await presenter.isPresentMatchingErrorCalled
                                    expect(isPresentMatchingErrorCalled).to(beTrue())
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

class NicknameRegistPresenterMock: NicknameRegistPresentationLogic {
    
    var isPresentInvitedUserCalled = false
    var isPresentEnabledConfirmButtonCalled = false
    var isPresentDisabledConfirmButtonCalled = false
    var isPresentNicknameErrorCalled = false
    var isPresentMatchingErrorCalled = false
    
    var lastInvitedUser: NicknameRegist.Model.InvitedUser?
    var lastNicknameError: Error?
    var lastMatchingError: Error?
    
    func presentInvitedUser(invitedUser: NicknameRegist.Model.InvitedUser) {
        self.isPresentInvitedUserCalled = true
        self.lastInvitedUser = invitedUser
    }
    
    func presentEnabledConfirmButton() {
        self.isPresentEnabledConfirmButtonCalled = true
    }
    
    func presentDisabledConfirmButton() {
        self.isPresentDisabledConfirmButtonCalled = true
    }
    
    func presentNicknameError(error: Error) {
        self.isPresentNicknameErrorCalled = true
        self.lastNicknameError = error
    }
    
    func presentMatchingError(error: Error) {
        self.isPresentMatchingErrorCalled = true
        self.lastMatchingError = error
    }
}


class NicknameRegistWorkerMock: NicknameRegistWorkerProtocol {
    
    var isInvitedUserCalled = false
    var isRequestSetNicknameCalled = false
    var isRequestMatchingCalled = false
    
    var lastNickname: String?
    
    var invitedUserResult: NicknameRegist.Model.InvitedUser?
    var requestSetNicknameResult: Bool?
    var requestMatchingResult: Bool?
    
    var invitedUser: NicknameRegist.Model.InvitedUser? {
        self.isInvitedUserCalled = true
        return self.invitedUserResult
    }
    
    func requestSetNickname(nickname: String) async throws {
        self.isRequestSetNicknameCalled = true
        self.lastNickname = nickname
        
        if let result = self.requestSetNicknameResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
    
    func requestMatching() async throws {
        self.isRequestMatchingCalled = true
        
        if let result = self.requestMatchingResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
}

class NicknameRegistRouterMock: NicknameRegistRoutingLogic {
    
}
