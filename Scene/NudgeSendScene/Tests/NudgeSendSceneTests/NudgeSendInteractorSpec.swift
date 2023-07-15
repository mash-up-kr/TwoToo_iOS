import Combine
import Foundation
import Quick
import Nimble
@testable import NudgeSendScene

final class NudgeSendInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: NudgeSendInteractor!
        var presenter: NudgeSendPresenterMock!
        var worker: NudgeSendWorkerMock!
        var router: NudgeSendRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await NudgeSendPresenterMock()
            router = await NudgeSendRouterMock()
            worker = NudgeSendWorkerMock()
            
            interactor = NudgeSendInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                remainingNudgeCount: 3
            )
            
            cancellables = []
        }
        
        describe("진입") {
            context("첫 진입 시") {
                beforeEach {
                    await interactor.didLoad()
                }
                
                it("남은 찌르기 횟수를 보여준다.") {
                    let isPresentRemainingNudgeCountCalled = await presenter.isPresentRemainingNudgeCountCalled
                    expect(isPresentRemainingNudgeCountCalled).to(beTrue())
                }
            }
        }
        
        describe("찌르기 문구 작성") {
            describe("찌르기 문구가 1자 이상이다.") {
                describe("찌르기 문구가 30자 이하이다.") {
                    context("찌르기 문구를 입력했을 때") {
                        beforeEach {
                            await interactor.didEnterNudgeComment(comment: "12345678901234567890123456789")
                        }
                        
                        it("찌르기 문구 데이터를 업데이트한다.") {
                            expect(interactor.nudgeComment).to(equal("12345678901234567890123456789"))
                        }
                        
                        it("보내기를 활성화하여 보여준다.") {
                            let isPresentEnabledSendCalled = await presenter.isPresentEnabledSendCalled
                            expect(isPresentEnabledSendCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("찌르기 문구가 0자이다.") {
                context("찌르기 문구를 입력했을 때") {
                    beforeEach {
                        await interactor.didEnterNudgeComment(comment: "")
                    }
                    
                    it("찌르기 문구 데이터를 업데이트한다.") {
                        expect(interactor.nudgeComment).to(equal(""))
                    }
                    
                    it("보내기를 비활성화하여 보여준다.") {
                        let isPresentDisabledSendCalled = await presenter.isPresentDisabledSendCalled
                        expect(isPresentDisabledSendCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("찌르기") {
            describe("찌르기 문구가 1자 이상이다.") {
                describe("찌르기 문구가 30자 이하이다.") {
                    beforeEach {
                        interactor.nudgeComment = "12345678901234567890123456789"
                    }
                    
                    context("보내기 버튼을 클릭했을 때") {
                        beforeEach {
                            await interactor.didTapSendButton()
                        }
                        
                        it("찌르기 문구로 칭찬하기 요청을 한다.") {
                            expect(worker.isRequestNudgeCalled).to(beTrue())
                            expect(worker.lastNudgeComment).to(equal("12345678901234567890123456789"))
                        }
                    }
                    
                    describe("찌르기 요청 결과가 성공이다.") {
                        beforeEach {
                            worker.requestNudgeResult = true
                        }
                        
                        context("보내기 버튼을 클릭했을 때") {
                            beforeEach {
                                await interactor.didTapSendButton()
                            }
                            
                            it("화면을 닫는다.") {
                                let isDismissCalled = await router.isDismissCalled
                                expect(isDismissCalled).to(beTrue())
                            }
                            
                            it("찌르기 성공을 보여준다.") {
                                let isPresentNudgeSuccessCalled = await presenter.isPresentNudgeSuccessCalled
                                expect(isPresentNudgeSuccessCalled).to(beTrue())
                            }
                        }
                    }
                    
                    describe("찌르기 오류를 보여준다.") {
                        beforeEach {
                            worker.requestNudgeResult = false
                        }
                        
                        context("보내기 버튼을 클릭했을 때") {
                            beforeEach {
                                await interactor.didTapSendButton()
                            }
                            
                            it("찌르기 오류를 보여준다.") {
                                let isPresentNudgeErrorCalled = await presenter.isPresentNudgeErrorCalled
                                let lastPresentNudgeError = await presenter.lastPresentNudgeError
                                expect(isPresentNudgeErrorCalled).to(beTrue())
                                expect(lastPresentNudgeError).to(matchError(NSError(domain: "Test", code: 999)))
                            }
                        }
                    }
                }
            }
        }
    }
}

class NudgeSendPresenterMock: NudgeSendPresentationLogic {
    
    var isPresentRemainingNudgeCountCalled = false
    var isPresentEnabledSendCalled = false
    var isPresentDisabledSendCalled = false
    var isPresentNudgeSuccessCalled = false
    var isPresentNudgeErrorCalled = false
    
    var lastRemainingNudgeCount: Int?
    var lastPresentNudgeError: Error?
    
    func presentRemainingNudgeCount(remainingNudgeCount: Int) {
        self.isPresentRemainingNudgeCountCalled = true
        self.lastRemainingNudgeCount = remainingNudgeCount
    }
    
    func presentEnabledSend() {
        self.isPresentEnabledSendCalled = true
    }
    
    func presentDisabledSend() {
        self.isPresentDisabledSendCalled = true
    }
    
    func presentNudgeSuccess() {
        self.isPresentNudgeSuccessCalled = true
    }
    
    func presentNudgeError(error: Error) {
        self.isPresentNudgeErrorCalled = true
        self.lastPresentNudgeError = error
    }
}

class NudgeSendWorkerMock: NudgeSendWorkerProtocol {
    
    var isRequestNudgeCalled = false
    
    var lastNudgeComment: String?
    
    var requestNudgeResult: Bool?
    
    func requestNudge(nudgeComment: String) async throws {
        self.isRequestNudgeCalled = true
        self.lastNudgeComment = nudgeComment
        
        if let result = self.requestNudgeResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
}

class NudgeSendRouterMock: NudgeSendRoutingLogic {
    
    var isDismissCalled = false
    
    func dismiss() {
        self.isDismissCalled = true
    }
}
