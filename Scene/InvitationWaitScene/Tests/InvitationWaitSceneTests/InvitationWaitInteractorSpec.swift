import Combine
import Foundation
import Quick
import Nimble
@testable import InvitationWaitScene

final class InvitationWaitInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: InvitationWaitInteractor!
        var presenter: InvitationWaitPresenterMock!
        var worker: InvitationWaitWorkerMock!
        var router: InvitationWaitRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await InvitationWaitPresenterMock()
            router = await InvitationWaitRouterMock()
            worker = InvitationWaitWorkerMock()
            
            interactor = InvitationWaitInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>(),
                invitationLink: nil
            )
            
            cancellables = []
        }
        
        describe("진입") {
            describe("전달받은 공유 링크가 존재한다.") {
                beforeEach {
                    interactor.invitationLink = "https://test.com//test"
                }
                
                context("첫 진입하였을 때") {
                    beforeEach {
                        await interactor.didLoad()
                    }
                    
                    it("전달받은 공유 링크로 공유하기 화면을 보여준다.") {
                        let lastInvitationLink = await presenter.lastInvitationLink
                        let isPresentSharedActivityCalled = await presenter.isPresentSharedActivityCalled
                        expect(lastInvitationLink).to(equal("https://test.com//test"))
                        expect(isPresentSharedActivityCalled).to(beTrue())
                    }
                }
            }
            
            describe("전달받은 공유 링크가 존재하지 않는다.") {
                beforeEach {
                    interactor.invitationLink = nil
                }
                
                context("첫 진입하였을 때") {
                    beforeEach {
                        await interactor.didLoad()
                    }
                }
            }
        }
        
        describe("새로고침") {
            context("새로고침 버튼을 눌렀을 때") {
                beforeEach {
                    await interactor.didTapRefreshButton()
                }
                
                it("파트너 조회를 요청한다.") {
                    expect(worker.isInquiryPartnerCalled).to(beTrue())
                }
            }
            
            describe("파트너 조회 요청이 성공하였다.") {
                describe("유저의 파트너가 존재한다.") {
                    beforeEach {
                        worker.inquiryPartnerResult = .success(.init(id: "test"))
                    }
                    
                    context("새로고침 버튼을 눌렀을 때") {
                        var didTriggerRouteToHomeSceneValue: Void? = nil

                        beforeEach {
                            let expectation = self.expectation(description: "홈 화면 이동 트리거")

                            interactor.didTriggerRouteToHomeScene
                                .sink { _ in
                                    didTriggerRouteToHomeSceneValue = ()
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapRefreshButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }
                        
                        it("홈 화면으로 이동한다") {
                            expect(didTriggerRouteToHomeSceneValue).to(beVoid())
                        }
                    }
                }
                
                describe("유저의 파트너가 존재하지 않는다.") {
                    beforeEach {
                        worker.inquiryPartnerResult = .success(nil)
                    }
                    
                    context("새로고침 버튼을 눌렀을 때") {
                        beforeEach {
                            await interactor.didTapRefreshButton()
                        }
                        
                        it("수락 대기 안내를 보여준다.") {
                            let isPresentAcceptanceWaitCalled = await presenter.isPresentAcceptanceWaitCalled
                            expect(isPresentAcceptanceWaitCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("파트너 조회 요청이 실패하였다.") {
                beforeEach {
                    worker.inquiryPartnerResult = .failure(NSError(domain: "Test", code: -1))
                }
                
                context("새로고침 버튼을 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapRefreshButton()
                    }
                    
                    it("파트너 조회 오류를 보여준다.") {
                        let isPresentPartnerInquiryErrorCalled = await presenter.isPresentPartnerInquiryErrorCalled
                        let lastPartnerInquiryError = await presenter.lastPartnerInquiryError
                        expect(isPresentPartnerInquiryErrorCalled).to(beTrue())
                        expect(lastPartnerInquiryError).to(matchError(NSError(domain: "Test", code: -1)))
                    }
                }
            }
        }
        
        describe("초대장 다시 보내기") {
            describe("로컬의 공유 링크가 존재한다.") {
                beforeEach {
                    worker.invitationLinkResult = "https://test.com//local"
                }
                
                context("초대장 다시 보내기 버튼을 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapResendButton()
                    }
                    
                    it("로컬의 공유 링크로 공유하기 화면을 보여준다.") {
                        let lastInvitationLink = await presenter.lastInvitationLink
                        let isPresentSharedActivityCalled = await presenter.isPresentSharedActivityCalled
                        expect(lastInvitationLink).to(equal("https://test.com//local"))
                        expect(isPresentSharedActivityCalled).to(beTrue())
                    }
                }
            }
            
            describe("로컬의 공유 링크가 존재하지 않는다.") {
                beforeEach {
                    worker.invitationLinkResult = nil
                }
                
                context("초대장 다시 보내기 버튼을 눌렀을 때") {
                    beforeEach {
                        await interactor.didTapResendButton()
                    }
                    
                    it("공유 링크 오류를 보여준다.") {
                        let isPresentInvitationLinkErrorCalled = await presenter.isPresentInvitationLinkErrorCalled
                        expect(isPresentInvitationLinkErrorCalled).to(beTrue())
                    }
                }
            }
        }
    }
}

class InvitationWaitPresenterMock: InvitationWaitPresentationLogic {
    
    var isPresentSharedActivityCalled = false
    var isPresentAcceptanceWaitCalled = false
    var isPresentPartnerInquiryErrorCalled = false
    var isPresentInvitationLinkErrorCalled = false
    
    var lastInvitationLink: String?
    var lastPartnerInquiryError: Error?
    
    func presentSharedActivity(invitationLink: String) {
        self.isPresentSharedActivityCalled = true
        
        self.lastInvitationLink = invitationLink
    }
    
    func presentAcceptanceWait() {
        self.isPresentAcceptanceWaitCalled = true
    }
    
    func presentPartnerInquiryError(error: Error) {
        self.isPresentPartnerInquiryErrorCalled = true
        
        self.lastPartnerInquiryError = error
    }
    
    func presentInvitationLinkError() {
        self.isPresentInvitationLinkErrorCalled = true
    }
}

class InvitationWaitWorkerMock: InvitationWaitWorkerProtocol {
    
    var isInquiryPartnerCalled = false
    
    var invitationLinkResult: String?
    var inquiryPartnerResult: Result<InvitationWait.Model.Partner?, Error>?
    
    var invitationLink: String? {
        return self.invitationLinkResult
    }
    
    func inquiryPartner() async throws -> InvitationWait.Model.Partner? {
        self.isInquiryPartnerCalled = true
        
        switch self.inquiryPartnerResult {
            case .success(let partner):
                return partner
                
            case .failure(let error):
                throw error
                
            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
}

class InvitationWaitRouterMock: InvitationWaitRoutingLogic {
    
}
