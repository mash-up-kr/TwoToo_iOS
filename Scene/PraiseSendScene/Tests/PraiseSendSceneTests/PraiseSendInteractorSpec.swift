import Combine
import Foundation
import Quick
import Nimble
@testable import PraiseSendScene

final class PraiseSendInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: PraiseSendInteractor!
        var presenter: PraiseSendPresenterMock!
        var worker: PraiseSendWorkerMock!
        var router: PraiseSendRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await PraiseSendPresenterMock()
            router = await PraiseSendRouterMock()
            worker = PraiseSendWorkerMock()
            
            interactor = PraiseSendInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
        
        describe("진입") {
            
        }
        
        describe("칭찬 문구 작성") {
            describe("칭찬 문구가 1자 이상이다.") {
                describe("칭찬 문구가 20자 이하이다.") {
                    context("칭찬 문구를 입력했을 때") {
                        beforeEach {
                            await interactor.didEnterPraiseComment(comment: "1234567890123456789")
                        }
                        
                        it("칭찬 문구 데이터를 업데이트한다.") {
                            expect(interactor.praiseComment).to(equal("1234567890123456789"))
                        }
                        
                        it("보내기를 활성화하여 보여준다.") {
                            let isPresentEnabledSendCalled = await presenter.isPresentEnabledSendCalled
                            expect(isPresentEnabledSendCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("칭찬 문구가 0자이다.") {
                context("칭찬 문구를 입력했을 때") {
                    beforeEach {
                        await interactor.didEnterPraiseComment(comment: "")
                    }
                    
                    it("칭찬 문구 데이터를 업데이트한다.") {
                        expect(interactor.praiseComment).to(equal(""))
                    }
                    
                    it("보내기를 비활성화하여 보여준다.") {
                        let isPresentDisabledSendCalled = await presenter.isPresentDisabledSendCalled
                        expect(isPresentDisabledSendCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("칭찬하기") {
            describe("칭찬 문구가 1자 이상이다.") {
                describe("칭찬 문구가 20자 이하이다.") {
                    beforeEach {
                        interactor.praiseComment = "1234567890123456789"
                    }
                    
                    context("보내기 버튼을 클릭했을 때") {
                        beforeEach {
                            await interactor.didTapSendButton()
                        }
                        
                        it("칭찬 문구로 칭찬하기 요청을 한다.") {
                            expect(worker.isRequestPraiseCalled).to(beTrue())
                            expect(worker.lastPraiseComment).to(equal("1234567890123456789"))
                        }
                    }
                    
                    describe("칭찬하기 요청 결과가 성공이다.") {
                        beforeEach {
                            worker.requestPraiseResult = true
                        }
                        
                        context("보내기 버튼을 클릭했을 때") {
                            beforeEach {
                                await interactor.didTapSendButton()
                            }
                            
                            it("화면을 닫는다.") {
                                let isDismissCalled = await router.isDismissCalled
                                expect(isDismissCalled).to(beTrue())
                            }
                            
                            it("칭찬하기 성공을 보여준다.") {
                                let isPresentPraiseSuccessCalled = await presenter.isPresentPraiseSuccessCalled
                                expect(isPresentPraiseSuccessCalled).to(beTrue())
                            }
                        }
                    }
                    
                    describe("칭찬하기 오류를 보여준다.") {
                        beforeEach {
                            worker.requestPraiseResult = false
                        }
                        
                        context("보내기 버튼을 클릭했을 때") {
                            beforeEach {
                                await interactor.didTapSendButton()
                            }
                            
                            it("칭찬하기 오류를 보여준다.") {
                                let isPresentPraiseErrorCalled = await presenter.isPresentPraiseErrorCalled
                                let lastPresentPraiseError = await presenter.lastPresentPraiseError
                                expect(isPresentPraiseErrorCalled).to(beTrue())
                                expect(lastPresentPraiseError).to(matchError(NSError(domain: "Test", code: 999)))
                            }
                        }
                    }
                }
            }
        }
    }
}

class PraiseSendPresenterMock: PraiseSendPresentationLogic {
    
    var isPresentEnabledSendCalled = false
    var isPresentDisabledSendCalled = false
    var isPresentPraiseSuccessCalled = false
    var isPresentPraiseErrorCalled = false
    
    var lastPresentPraiseError: Error?
    
    func presentEnabledSend() {
        self.isPresentEnabledSendCalled = true
    }
    
    func presentDisabledSend() {
        self.isPresentDisabledSendCalled = true
    }
    
    func presentPraiseSuccess() {
        self.isPresentPraiseSuccessCalled = true
    }
    
    func presentPraiseError(error: Error) {
        self.isPresentPraiseErrorCalled = true
        self.lastPresentPraiseError = error
    }
}

class PraiseSendWorkerMock: PraiseSendWorkerProtocol {
    
    var isRequestPraiseCalled = false
    
    var lastPraiseComment: String?
    
    var requestPraiseResult: Bool?
    
    func requestPraise(praiseComment: String) async throws {
        self.isRequestPraiseCalled = true
        self.lastPraiseComment = praiseComment
        
        if let result = self.requestPraiseResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
}

class PraiseSendRouterMock: PraiseSendRoutingLogic {
    
    var isDismissCalled = false
    
    func dismiss() {
        self.isDismissCalled = true
    }
}
