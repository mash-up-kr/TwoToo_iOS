import Combine
import Foundation
import Quick
import Nimble
@testable import InvitationSendScene

final class InvitationSendInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: InvitationSendInteractor!
        var presenter: InvitationSendPresenterMock!
        var worker: InvitationSendWorkerMock!
        var router: InvitationSendRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await InvitationSendPresenterMock()
            router = await InvitationSendRouterMock()
            worker = InvitationSendWorkerMock()
            
            interactor = InvitationSendInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                didTriggerRouteToInvitationWaitScene: PassthroughSubject<String, Never>()
            )
            
            cancellables = []
        }
        
        describe("진입") {
            
        }
        
        describe("초대장 보내기") {
            context("초대장 보내기 버튼 눌렀을 때") {
                beforeEach {
                    await interactor.didTapInvitationSendButton()
                }
                
                it("공유 링크 생성 요청을 한다.") {
                    expect(worker.isRequestInvitationLinkCreateCalled).to(beTrue())
                }
            }
            
            describe("공유 링크 생성 요청 결과가 성공이다.") {
                beforeEach {
                    worker.requestInvitationLinkCreateResult = .success("https://test.com/test")
                }
                
                context("초대장 보내기 버튼 눌렀을 때") {
                    var didTriggerRouteToInvitationWaitSceneValue: String? = nil

                    beforeEach {
                        let expectation = self.expectation(description: "대기 화면 이동 트리거")

                        interactor.didTriggerRouteToInvitationWaitScene
                            .sink { value in
                                didTriggerRouteToInvitationWaitSceneValue = value
                                expectation.fulfill()
                            }
                            .store(in: &cancellables)

                        await interactor.didTapInvitationSendButton()

                        await self.fulfillment(of: [expectation], timeout: 3)
                    }
                    
                    it("초대장을 전송함으로 변경 요청한다.") {
                        expect(worker.isSetIsInvitationSendCalled).to(beTrue())
                        expect(worker.lastIsInvitationSend).to(beTrue())
                    }

                    it("공유 링크를 전달하며, 대기 화면으로 이동한다") {
                        expect(didTriggerRouteToInvitationWaitSceneValue).to(equal("https://test.com/test"))
                    }
                }
            }
            
            describe("공유 링크 생성 요청 결과가 실패이다.") {
                beforeEach {
                    worker.requestInvitationLinkCreateResult = .failure(NSError(domain: "Test", code: -1))
                }
                
                context("초대장 보내기 버튼 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapInvitationSendButton()
                    }
                    
                    it("공유 링크 생성 오류를 보여준다.") {
                        let isPresentInvitaitonLinkCreateErrorCalled = await presenter.isPresentInvitaitonLinkCreateErrorCalled
                        let lastInvitaitonLinkCreateError = await presenter.lastInvitaitonLinkCreateError
                        expect(isPresentInvitaitonLinkCreateErrorCalled).to(beTrue())
                        expect(lastInvitaitonLinkCreateError).to(matchError(NSError(domain: "Test", code: -1)))
                    }
                }
            }
        }
    }
}

class InvitationSendPresenterMock: InvitationSendPresentationLogic {
    
    var isPresentInvitaitonLinkCreateErrorCalled = false
    
    var lastInvitaitonLinkCreateError: Error?
    
    func presentInvitaitonLinkCreateError(error: Error) {
        self.isPresentInvitaitonLinkCreateErrorCalled = true
        self.lastInvitaitonLinkCreateError = error
    }
}

class InvitationSendWorkerMock: InvitationSendWorkerProtocol {
    
    var isRequestInvitationLinkCreateCalled = false
    var isSetIsInvitationSendCalled = false
    
    var lastIsInvitationSend: Bool?
    
    var requestInvitationLinkCreateResult: Result<String, Error>?
    
    func requestInvitationLinkCreate() async throws -> String {
        self.isRequestInvitationLinkCreateCalled = true
        
        switch self.requestInvitationLinkCreateResult {
            case let .success(link):
                return link
                
            case let .failure(error):
                throw error
                
            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    var isInvitationSend: Bool {
        get {
            return false
        }
        set {
            self.lastIsInvitationSend = newValue
            self.isSetIsInvitationSendCalled = true
        }
    }
}

class InvitationSendRouterMock: InvitationSendRoutingLogic {
    
}
