import Combine
import Foundation
import Quick
import Nimble
@testable import ChallengeHistoryScene

final class ChallengeHistoryInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ChallengeHistoryInteractor!
        var presenter: ChallengeHistoryPresenterMock!
        var worker: ChallengeHistoryWorkerMock!
        var router: ChallengeHistoryRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ChallengeHistoryPresenterMock()
            router = await ChallengeHistoryRouterMock()
            worker = ChallengeHistoryWorkerMock()
            
            interactor = ChallengeHistoryInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                challenge: .init(
                    id: "1", name: "", startDate: Date(), endDate: Date(),
                    myInfo: .init(id: "1", nickname: "", certificates: [
                        .init(id: "1", certificateImageUrl: "", certificateComment: "", certificateTime: Date()),
                        .init(id: "3", certificateImageUrl: "", certificateComment: "", certificateTime: Date()),
                        .init(id: "5", certificateImageUrl: "", certificateComment: "", certificateTime: Date())
                    ]),
                    partnerInfo: .init(id: "2", nickname: "", certificates: [
                        .init(id: "2", certificateImageUrl: "", certificateComment: "", certificateTime: Date()),
                        .init(id: "4", certificateImageUrl: "", certificateComment: "", certificateTime: Date()),
                        .init(id: "6", certificateImageUrl: "", certificateComment: "", certificateTime: Date())
                    ])
                )
            )
            
            cancellables = []
        }
        
        describe("진입") {
            context("첫 진입하였을 때") {
                beforeEach {
                    await interactor.didLoad()
                }
                
                it("챌린지 상세 데이터로 챌린지 상세를 보여준다.") {
                    let isPresentChallengeCalled = await presenter.isPresentChallengeCalled
                    let lastChallenge = await presenter.lastChallenge
                    expect(isPresentChallengeCalled).to(beTrue())
                    expect(lastChallenge).to(equal(interactor.challenge))
                }
            }
        }
        
        describe("인증") {
            context("인증하기 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapCertificate()
                }
                
                it("인증하기 화면으로 이동한다.") {
                    let isRouteToChallengeCertificateSceneCalled = await router.isRouteToChallengeCertificateSceneCalled
                    expect(isRouteToChallengeCertificateSceneCalled).to(beTrue())
                }
            }
        }
        
        describe("인증 상세") {
            context("인증을 선택하였을 때") {
                beforeEach {
                    await interactor.didSelectCertificate(certificateID: "2")
                }
                
                it("선택한 인증을 전달하며 인증 상세 화면으로 이동한다.") {
                    let isRouteToChallengeHistoryDetailSceneCalled = await router.isRouteToChallengeHistoryDetailSceneCalled
                    let lastCertificate = await router.lastCertificate
                    expect(isRouteToChallengeHistoryDetailSceneCalled).to(beTrue())
                    expect(lastCertificate).to(equal(.init(id: "2", certificateImageUrl: "", certificateComment: "", certificateTime: Date())))
                }
            }
        }
        
        describe("챌린지 그만두기") {
            context("옵션 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapOptionButton()
                }
                
                it("옵션 팝업을 보여준다.") {
                    let isPresentOptionPopupCalled = await presenter.isPresentOptionPopupCalled
                    expect(isPresentOptionPopupCalled).to(beTrue())
                }
            }
            
            context("옵션 팝업의 챌린지 그만두기 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapOptionPopupQuitButton()
                }
                
                it("챌린지 그만두기 팝업을 보여준다.") {
                    let isPresentQuitPopupCalled = await presenter.isPresentQuitPopupCalled
                    expect(isPresentQuitPopupCalled).to(beTrue())
                }
            }
            
            context("챌린지 그만두기 팝업의 취소 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapQuitPopupCancelButton()
                }
                
                it("챌린지 그만두기 팝업을 제거한다.") {
                    let isDismissQuitPopupCalled = await presenter.isDismissQuitPopupCalled
                    expect(isDismissQuitPopupCalled).to(beTrue())
                }
            }
            
            context("챌린지 그만두기 팝업의 배경을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapQuitPopupBackground()
                }
                
                it("챌린지 그만두기 팝업을 제거한다.") {
                    let isDismissQuitPopupCalled = await presenter.isDismissQuitPopupCalled
                    expect(isDismissQuitPopupCalled).to(beTrue())
                }
            }
            
            context("챌린지 그만두기 팝업의 그만두기 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapQuitPopupQuitButton()
                }
                
                it("챌린지 상세 데이터의 챌린지 ID로 챌린지 그만두기 요청을 한다.") {
                    expect(worker.isRequestChallengeQuitCalled).to(beTrue())
                }
            }
            
            describe("챌린지 그만두기 결과가 성공이다.") {
                beforeEach {
                    worker.requestChallengeQuitResult = true
                }
                
                context("챌린지 그만두기 팝업의 그만두기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapQuitPopupQuitButton()
                    }
                    
                    it("챌린지 그만두기 성공을 보여준다.") {
                        let isPresentChallengeQuitSuccessCalled = await presenter.isPresentChallengeQuitSuccessCalled
                        expect(isPresentChallengeQuitSuccessCalled).to(beTrue())
                    }
                    
                    it("화면을 닫는다.") {
                        let isDismissCalled = await router.isDismissCalled
                        expect(isDismissCalled).to(beTrue())
                    }
                }
            }
            
            describe("챌린지 그만두기 결과가 실패이다.") {
                beforeEach {
                    worker.requestChallengeQuitResult = false
                }
                
                context("챌린지 그만두기 팝업의 그만두기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapQuitPopupQuitButton()
                    }
                    
                    it("챌린지 그만두기 오류를 보여준다.") {
                        let isPresentChallengeQuitErrorCalled = await presenter.isPresentChallengeQuitErrorCalled
                        let lastError = await presenter.lastError
                        expect(isPresentChallengeQuitErrorCalled).to(beTrue())
                        expect(lastError).to(matchError(NSError(domain: "Test", code: 999)))
                    }
                }
            }
        }
        
        describe("뒤로가기") {
            context("뒤로가기 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapBackButton()
                }
                
                it("화면을 닫는다.") {
                    let isDismissCalled = await router.isDismissCalled
                    expect(isDismissCalled).to(beTrue())
                }
            }
        }
    }
}

class ChallengeHistoryPresenterMock: ChallengeHistoryPresentationLogic {

    var isPresentChallengeCalled = false
    var isPresentOptionPopupCalled = false
    var isPresentQuitPopupCalled = false
    var isDismissQuitPopupCalled = false
    var isPresentChallengeQuitSuccessCalled = false
    var isPresentChallengeQuitErrorCalled = false
    
    var lastChallenge: ChallengeHistory.Model.Challenge?
    var lastError: Error?

    func presentChallenge(challenge: ChallengeHistory.Model.Challenge) {
        self.isPresentChallengeCalled = true
        self.lastChallenge = challenge
    }

    func presentOptionPopup() {
        self.isPresentOptionPopupCalled = true
    }

    func presentQuitPopup() {
        self.isPresentQuitPopupCalled = true
    }

    func dismissQuitPopup() {
        self.isDismissQuitPopupCalled = true
    }

    func presentChallengeQuitSuccess() {
        self.isPresentChallengeQuitSuccessCalled = true
    }

    func presentChallengeQuitError(error: Error) {
        self.isPresentChallengeQuitErrorCalled = true
        self.lastError = error
    }
}

class ChallengeHistoryWorkerMock: ChallengeHistoryWorkerProtocol {

    var isRequestChallengeQuitCalled = false
    var lastChallengeID: String?
    
    var requestChallengeQuitResult: Bool?
    
    func requestChallengeQuit(challengeID: String) async throws {
        self.isRequestChallengeQuitCalled = true
        self.lastChallengeID = challengeID
        
        if let result = self.requestChallengeQuitResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
}

class ChallengeHistoryRouterMock: ChallengeHistoryRoutingLogic {

    var isRouteToChallengeCertificateSceneCalled = false
    var isRouteToChallengeHistoryDetailSceneCalled = false
    var isDismissCalled = false

    var lastCertificate: ChallengeHistory.Model.Certificate?
    
    func routeToChallengeCertificateScene() {
        self.isRouteToChallengeCertificateSceneCalled = true
    }

    func routeToChallengeHistoryDetailScene(certificate: ChallengeHistory.Model.Certificate) {
        self.isRouteToChallengeHistoryDetailSceneCalled = true
        self.lastCertificate = certificate
    }

    func dismiss() {
        self.isDismissCalled = true
    }
}
