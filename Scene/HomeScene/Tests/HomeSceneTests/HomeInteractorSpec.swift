import Combine
import Foundation
import Quick
import Nimble
@testable import HomeScene

final class HomeInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: HomeInteractor!
        var presenter: HomePresenterMock!
        var worker: HomeWorkerMock!
        var router: HomeRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await HomePresenterMock()
            router = await HomeRouterMock()
            worker = HomeWorkerMock()
            
            interactor = HomeInteractor(
                presenter: presenter,
                router: router,
                worker: worker,
                didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never>()
            )
            
            cancellables = []
        }
        
        describe("진입") {
            context("진입 시") {
                beforeEach {
                    await interactor.didAppear()
                }
                
                it("홈 조회를 요청한다.") {
                    expect(worker.isFetchHomeInfoCalled).to(beTrue())
                }
            }
            
            describe("홈 조회 요청 결과가 성공이다.") {
                describe("챌린지 상태가 챌린지 생성전이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .created,
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .created,
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 생성전 화면을 보여준다.") {
                            let isPresentChallengeCreatedCalled = await presenter.isPresentChallengeCreatedCalled
                            expect(isPresentChallengeCreatedCalled).to(beTrue())
                        }
                    }
                }
                
                describe("챌린지 상태가 챌린지 대기중이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .waiting,
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .waiting,
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 대기중 화면을 보여준다.") {
                            let isPresentChallengeWaitingCalled = await presenter.isPresentChallengeWaitingCalled
                            expect(isPresentChallengeWaitingCalled).to(beTrue())
                        }
                    }
                }
                
                describe("챌린지 상태가 챌린지 시작 전이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .beforeStart,
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .beforeStart,
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 시작 전 화면을 보여준다.") {
                            let isPresentChallengeBeforeStartCalled = await presenter.isPresentChallengeBeforeStartCalled
                            expect(isPresentChallengeBeforeStartCalled).to(beTrue())
                        }
                    }
                }
                
                describe("챌린지 상태가 챌린지 시작일 전이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .beforeStartDate,
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .beforeStartDate,
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 시작일 전 화면을 보여준다.") {
                            let isPresentChallengeBeforeStartDateCalled = await presenter.isPresentChallengeBeforeStartDateCalled
                            expect(isPresentChallengeBeforeStartDateCalled).to(beTrue())
                        }
                    }
                }
                
                describe("챌린지 상태가 챌린지 시작일 초과이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .afterStartDate,
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .afterStartDate,
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 시작일 초과 화면을 보여준다.") {
                            let isPresentChallengeAfterStartDateCalled = await presenter.isPresentChallengeAfterStartDateCalled
                            expect(isPresentChallengeAfterStartDateCalled).to(beTrue())
                        }
                    }
                }
                
                describe("챌린지 상태가 챌린지 진행중이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .inProgress(.bothUncertificated),
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .inProgress(.bothUncertificated),
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 진행중 화면을 보여준다.") {
                            let isPresentChallengeInProgressCalled = await presenter.isPresentChallengeInProgressCalled
                            expect(isPresentChallengeInProgressCalled).to(beTrue())
                        }
                    }
                    
                    describe("챌린지 진행 중 상태가 둘 다 인증이다.") {
                        describe("챌린지 둘다 인증 상태가 확인되지 않음이다.") {
                            beforeEach {
                                worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                                    status: .inProgress(.bothCertificated(.uncomfirmed)),
                                    myInfo: .init(id: "", nickname: "Test"),
                                    partnerInfo: .init(id: "", nickname: "Test")
                                )))
                            }
                            
                            context("진입 시") {
                                beforeEach {
                                    await interactor.didAppear()
                                }
                                
                                it("둘다 인증 팝업을 보여준다.") {
                                    let isPresentBothCertificationPopupCalled = await presenter.isPresentBothCertificationPopupCalled
                                    expect(isPresentBothCertificationPopupCalled).to(beTrue())
                                }
                            }
                        }
                    }
                }
                
                describe("챌린지 상태가 챌린지 완료이다.") {
                    beforeEach {
                        worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                            status: .completed(.comfirmed),
                            myInfo: .init(id: "", nickname: "Test"),
                            partnerInfo: .init(id: "", nickname: "Test")
                        )))
                    }
                    
                    context("진입 시") {
                        beforeEach {
                            await interactor.didAppear()
                        }
                        
                        it("조회된 챌린지 정보로 챌린지 정보 데이터를 업데이트한다.") {
                            expect(interactor.challenge).to(equal(.init(
                                status: .completed(.comfirmed),
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        it("챌린지 완료 화면을 보여준다.") {
                            let isPresentChallengeCompletedCalled = await presenter.isPresentChallengeCompletedCalled
                            expect(isPresentChallengeCompletedCalled).to(beTrue())
                        }
                    }
                    
                    describe("챌린지 완료 상태가 확인되지 않음이다.") {
                        beforeEach {
                            worker.fetchHomeInfoResult = .success(.init(challenge: .init(
                                status: .completed(.uncomfirmed),
                                myInfo: .init(id: "", nickname: "Test"),
                                partnerInfo: .init(id: "", nickname: "Test")
                            )))
                        }
                        
                        context("진입 시") {
                            beforeEach {
                                await interactor.didAppear()
                            }
                            
                            it("챌린지 완료 팝업을 보여준다.") {
                                let isPresentCompletedPopupCalled = await presenter.isPresentCompletedPopupCalled
                                expect(isPresentCompletedPopupCalled).to(beTrue())
                            }
                        }
                    }
                }
            }
            
            describe("홈 조회 요청 결과가 실패이다.") {
                beforeEach {
                    worker.fetchHomeInfoResult = .failure(NSError(domain: "Test", code: -1))
                }
                
                context("진입 시") {
                    beforeEach {
                        await interactor.didAppear()
                    }
                    
                    it("홈 오류를 보여준다.") {
                        let isPresentHomeErrorCalled = await presenter.isPresentHomeErrorCalled
                        let lastHomeError = await presenter.lastHomeError
                        expect(isPresentHomeErrorCalled).to(beTrue())
                        expect(lastHomeError).to(matchError(NSError(domain: "Test", code: -1)))
                    }
                }
            }
        }
        
        describe("챌린지 생성") {
            describe("현재 챌린지 상태가 챌린지 생성전이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .created,
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("챌린지 시작하기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapChallengeStartButton()
                    }
                    
                    it("챌린지 기본 정보 화면으로 이동한다.") {
                        let isRouteToChallengeEssentialInfoInputSceneCalled = await router.isRouteToChallengeEssentialInfoInputSceneCalled
                        expect(isRouteToChallengeEssentialInfoInputSceneCalled).to(beTrue())
                    }
                }
            }
            
            describe("현재 챌린지 상태가 챌린지 시작일 초과이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .afterStartDate,
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("챌린지 시작하기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapChallengeStartButton()
                    }
                    
                    it("챌린지 기본 정보 화면으로 이동한다.") {
                        let isRouteToChallengeEssentialInfoInputSceneCalled = await router.isRouteToChallengeEssentialInfoInputSceneCalled
                        expect(isRouteToChallengeEssentialInfoInputSceneCalled).to(beTrue())
                    }
                }
            }
            
            describe("현재 챌린지 상태가 챌린지 대기중이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .waiting,
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("챌린지 확인하기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapChallengeConfirmButton()
                    }
                    
                    it("확인(view) 진입점을 전달하며, 챌린지 정보 확인 화면으로 이동한다.") {
                        let isRouteToChallengeConfirmSceneCalled = await router.isRouteToChallengeConfirmSceneCalled
                        let lastEntryPoint = await router.lastEntryPoint
                        expect(isRouteToChallengeConfirmSceneCalled).to(beTrue())
                        expect(lastEntryPoint).to(equal("view"))
                    }
                }
            }
            
            describe("현재 챌린지 상태가 챌린지 시작일 전이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .beforeStartDate,
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("챌린지 확인하기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapChallengeConfirmButton()
                    }
                    
                    it("확인(view) 진입점을 전달하며, 챌린지 정보 확인 화면으로 이동한다.") {
                        let isRouteToChallengeConfirmSceneCalled = await router.isRouteToChallengeConfirmSceneCalled
                        let lastEntryPoint = await router.lastEntryPoint
                        expect(isRouteToChallengeConfirmSceneCalled).to(beTrue())
                        expect(lastEntryPoint).to(equal("view"))
                    }
                }
            }
            
            describe("현재 챌린지 상태가 챌린지 시작전이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .beforeStart,
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("챌린지 확인하기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapChallengeConfirmButton()
                    }
                    
                    it("수락(accept) 진입점을 전달하며, 챌린지 정보 확인 화면으로 이동한다.") {
                        let isRouteToChallengeConfirmSceneCalled = await router.isRouteToChallengeConfirmSceneCalled
                        let lastEntryPoint = await router.lastEntryPoint
                        expect(isRouteToChallengeConfirmSceneCalled).to(beTrue())
                        expect(lastEntryPoint).to(equal("accept"))
                    }
                }
            }
        }
        
        describe("챌린지 완료") {
            context("챌린지 완료 팝업의 배경을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapChallengeCompletedPopupBackground()
                }
                
                it("확인함으로 챌린지 완료 확인 여부 업데이트를 요청한다.") {
                    expect(worker.isChallengeCompletedConfirmedCalled).to(beTrue())
                    expect(worker.lastChallengeCompletedConfirmed).to(beTrue())
                }
                
                it("챌린지 완료 팝업을 닫는다.") {
                    let isDismissCompletedPopupCalled = await presenter.isDismissCompletedPopupCalled
                    expect(isDismissCompletedPopupCalled).to(beTrue())
                }
            }
            
            context("챌린지 완료 팝업의 확인 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapChallengeCompletedPopupConfirmButton()
                }
                
                it("확인함으로 챌린지 완료 확인 여부 업데이트를 요청한다.") {
                    expect(worker.isChallengeCompletedConfirmedCalled).to(beTrue())
                    expect(worker.lastChallengeCompletedConfirmed).to(beTrue())
                }
                
                it("챌린지 완료 팝업을 닫는다.") {
                    let isDismissCompletedPopupCalled = await presenter.isDismissCompletedPopupCalled
                    expect(isDismissCompletedPopupCalled).to(beTrue())
                }
            }
            
            describe("현재 챌린지 상태가 챌린지 완료이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        id: "Test",
                        status: .completed(.uncomfirmed),
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("챌린지 완료하기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapChallengeCompleteButton()
                    }
                    
                    it("챌린지 완료 요청을 한다.") {
                        let isRequestChallengeCompleteCalled = worker.isRequestChallengeCompleteCalled
                        expect(isRequestChallengeCompleteCalled).to(beTrue())
                    }
                }
                
                describe("챌린지 완료 요청 결과가 성공이다.") {
                    beforeEach {
                        worker.requestChallengeCompleteResult = true
                    }
                    
                    context("챌린지 완료하기 버튼을 클릭하였을 때") {
                        var didTriggerRouteToHistorySceneValue: Bool? = nil
                        
                        beforeEach {
                            let expectation = self.expectation(description: "히스토리 화면 이동 트리거")

                            interactor.didTriggerRouteToHistoryScene
                                .sink { isUpdated in
                                    didTriggerRouteToHistorySceneValue = isUpdated
                                    expectation.fulfill()
                                }
                                .store(in: &cancellables)

                            await interactor.didTapChallengeCompleteButton()

                            await self.fulfillment(of: [expectation], timeout: 3)
                        }
                        
                        it("업데이트 됨을 전달하며 히스토리 화면으로 이동한다.") {
                            expect(didTriggerRouteToHistorySceneValue).to(beTrue())
                        }
                    }
                }
                
                describe("챌린지 완료 요청 결과가 실패이다.") {
                    beforeEach {
                        worker.requestChallengeCompleteResult = false
                    }
                    
                    context("챌린지 완료하기 버튼을 클릭하였을 때") {
                        beforeEach {
                            await interactor.didTapChallengeCompleteButton()
                        }
                        
                        it("챌린지 완료 요청 오류를 보여준다.") {
                            let isPresentCompleteRequestErrorCalled = await presenter.isPresentCompleteRequestErrorCalled
                            expect(isPresentCompleteRequestErrorCalled).to(beTrue())
                        }
                    }
                }
            }
        }
        
        describe("칭찬") {
            context("둘다 인증 팝업의 괜찮아요(no) 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapBothCertificationPopupNoOption()
                }
                
                it("둘다 인증 팝업을 닫는다.") {
                    let isDismissBothCertificationPopupCalled = await presenter.isDismissBothCertificationPopupCalled
                    expect(isDismissBothCertificationPopupCalled).to(beTrue())
                }
            }
            
            context("둘다 인증 팝업의 배경을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapBothCertificationPopupBackground()
                }
                
                it("둘다 인증 팝업을 닫는다.") {
                    let isDismissBothCertificationPopupCalled = await presenter.isDismissBothCertificationPopupCalled
                    expect(isDismissBothCertificationPopupCalled).to(beTrue())
                }
            }
            
            context("둘다 인증 팝업의 칭찬하기(yes) 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapBothCertificationPopupYesOption()
                }
                
                it("확인함으로 둘다 인증 확인 여부 업데이트를 요청한다.") {
                    expect(worker.isBothCertificationConfirmedCalled).to(beTrue())
                    expect(worker.lastBothCertificationConfirmed).to(beTrue())
                }
                
                it("둘다 인증 팝업을 닫는다.") {
                    let isDismissBothCertificationPopupCalled = await presenter.isDismissBothCertificationPopupCalled
                    expect(isDismissBothCertificationPopupCalled).to(beTrue())
                }
                
                it("칭찬하기 화면으로 이동한다.") {
                    let isRouteToPraiseSendSceneCalled = await router.isRouteToPraiseSendSceneCalled
                    expect(isRouteToPraiseSendSceneCalled).to(beTrue())
                }
            }
            
            describe("현재 챌린지의 내 칭찬 문구가 빈 값이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .inProgress(.bothCertificated(.comfirmed)),
                        myInfo: .init(id: "", nickname: "Test", todayCert: .init(id: "", complimentComment: "")),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                context("내 칭찬 문구를 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapMyComplimentCommnet()
                    }
                    
                    it("칭찬하기 화면으로 이동한다.") {
                        let isRouteToPraiseSendSceneCalled = await router.isRouteToPraiseSendSceneCalled
                        expect(isRouteToPraiseSendSceneCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("인증") {
            describe("현재 챌린지의 나의 오늘 인증 정보가 존재하지 않는다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .inProgress(.bothCertificated(.comfirmed)),
                        myInfo: .init(id: "", nickname: "Test", todayCert: nil),
                        partnerInfo: .init(id: "", nickname: "Test")
                    )
                }
                
                context("내 꽃을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapMyFlower()
                    }
                    
                    it("인증하기 화면으로 이동한다.") {
                        let isRouteToChallengeCertificateSceneCalled = await router.isRouteToChallengeCertificateSceneCalled
                        expect(isRouteToChallengeCertificateSceneCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("찌르기") {
            describe("현재 챌린지의 찌르기 남은 횟수가 1개 이상이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .inProgress(.bothCertificated(.comfirmed)),
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test"),
                        stickRemaining: 1
                    )
                }
                
                context("찌르기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapStickButton()
                    }
                    
                    it("찌르기 화면으로 이동한다.") {
                        let isRouteToNudgeSendSceneCalled = await router.isRouteToNudgeSendSceneCalled
                        expect(isRouteToNudgeSendSceneCalled).to(beTrue())
                    }
                }
            }
            
            describe("현재 챌린지의 찌르기 남은 횟수가 0개이다.") {
                beforeEach {
                    interactor.challenge = .init(
                        status: .inProgress(.bothCertificated(.comfirmed)),
                        myInfo: .init(id: "", nickname: "Test"),
                        partnerInfo: .init(id: "", nickname: "Test"),
                        stickRemaining: 0
                    )
                }
                
                context("찌르기 버튼을 클릭하였을 때") {
                    beforeEach {
                        await interactor.didTapStickButton()
                    }
                    
                    it("찌르기 횟수 초과 오류를 보여준다.") {
                        let isPresentExceededStickCountErrorCalled = await presenter.isPresentExceededStickCountErrorCalled
                        expect(isPresentExceededStickCountErrorCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("챌린지 히스토리") {
            context("챌린지 정보를 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapChallengeInfo()
                }
                
                it("챌린지 히스토리 화면으로 이동한다.") {
                    let isRouteToChallengeHistorySceneCalled = await router.isRouteToChallengeHistorySceneCalled
                    expect(isRouteToChallengeHistorySceneCalled).to(beTrue())
                }
            }
        }
        
        describe("설명서") {
            context("설명서 버튼을 클릭하였을 때") {
                beforeEach {
                    await interactor.didTapGuideButton()
                }
                
                it("설명서 화면으로 이동한다.") {
                    let isRouteToGuideSceneCalled = await router.isRouteToGuideSceneCalled
                    expect(isRouteToGuideSceneCalled).to(beTrue())
                }
            }
        }
    }
}

class HomePresenterMock: HomePresentationLogic {
    
    var isPresentChallengeCreatedCalled = false
    var isPresentChallengeWaitingCalled = false
    var isPresentChallengeBeforeStartCalled = false
    var isPresentChallengeBeforeStartDateCalled = false
    var isPresentChallengeAfterStartDateCalled = false
    var isPresentChallengeInProgressCalled = false
    var isPresentBothCertificationPopupCalled = false
    var isDismissBothCertificationPopupCalled = false
    var isPresentChallengeCompletedCalled = false
    var isPresentCompletedPopupCalled = false
    var isDismissCompletedPopupCalled = false
    var isPresentHomeErrorCalled = false
    var isPresentCompleteRequestErrorCalled = false
    var isPresentExceededStickCountErrorCalled = false
    
    var lastChallenge: Home.Model.Challenge?
    var lastHomeError: Error?
    var lastCompleteRequestError: Error?
    
    func presentChallengeCreated(challenge: Home.Model.Challenge) {
        self.isPresentChallengeCreatedCalled = true
        self.lastChallenge = challenge
    }
    
    func presentChallengeWaiting(challenge: Home.Model.Challenge) {
        self.isPresentChallengeWaitingCalled = true
        self.lastChallenge = challenge
    }
    
    func presentChallengeBeforeStart(challenge: Home.Model.Challenge) {
        self.isPresentChallengeBeforeStartCalled = true
        self.lastChallenge = challenge
    }
    
    func presentChallengeBeforeStartDate(challenge: Home.Model.Challenge) {
        self.isPresentChallengeBeforeStartDateCalled = true
        self.lastChallenge = challenge
    }
    
    func presentChallengeAfterStartDate(challenge: Home.Model.Challenge) {
        self.isPresentChallengeAfterStartDateCalled = true
        self.lastChallenge = challenge
    }
    
    func presentChallengeInProgress(challenge: Home.Model.Challenge) {
        self.isPresentChallengeInProgressCalled = true
        self.lastChallenge = challenge
    }
    
    func presentBothCertificationPopup() {
        self.isPresentBothCertificationPopupCalled = true
    }
    
    func dismissBothCertificationPopup() {
        self.isDismissBothCertificationPopupCalled = true
    }
    
    func presentChallengeCompleted(challenge: Home.Model.Challenge) {
        self.isPresentChallengeCompletedCalled = true
        self.lastChallenge = challenge
    }
    
    func presentCompletedPopup(challenge: Home.Model.Challenge) {
        self.isPresentCompletedPopupCalled = true
        self.lastChallenge = challenge
    }
    
    func dismissCompletedPopup() {
        self.isDismissCompletedPopupCalled = true
    }
    
    func presentHomeError(error: Error) {
        self.isPresentHomeErrorCalled = true
        self.lastHomeError = error
    }
    
    func presentCompleteRequestError(error: Error) {
        self.isPresentCompleteRequestErrorCalled = true
        self.lastCompleteRequestError = error
    }
    
    func presentExceededStickCountError() {
        self.isPresentExceededStickCountErrorCalled = true
    }
}

class HomeWorkerMock: HomeWorkerProtocol {
    
    var isChallengeCompletedConfirmedCalled = false
    var isBothCertificationConfirmedCalled = false
    var isFetchHomeInfoCalled = false
    var isRequestChallengeCompleteCalled = false
    
    var lastChallengeCompletedConfirmed: Bool?
    var lastBothCertificationConfirmed: Bool?
    
    var lastChallengeID: String?
    
    var challengeCompletedConfirmedResult: Bool?
    var bothCertificationConfirmedResult: Bool?
    var fetchHomeInfoResult: Result<Home.Model.HomeInfo, Error>?
    var requestChallengeCompleteResult: Bool?
    
    var challengeCompletedConfirmed: Bool {
        get {
            return self.challengeCompletedConfirmedResult ?? false
        }
        set {
            self.isChallengeCompletedConfirmedCalled = true
            self.lastChallengeCompletedConfirmed = newValue
        }
    }
    
    var bothCertificationConfirmed: Bool {
        get {
            return self.bothCertificationConfirmedResult ?? false
        }
        set {
            self.isBothCertificationConfirmedCalled = true
            self.lastBothCertificationConfirmed = newValue
        }
    }
    
    func fetchHomeInfo() async throws -> Home.Model.HomeInfo {
        self.isFetchHomeInfoCalled = true
        
        switch self.fetchHomeInfoResult {
            case .success(let homeInfo):
                return homeInfo

            case .failure(let error):
                throw error

            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    func requestChallengeComplete(challengeID: String) async throws {
        self.isRequestChallengeCompleteCalled = true
        self.lastChallengeID = challengeID
        
        if let result = self.requestChallengeCompleteResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
}

class HomeRouterMock: HomeRoutingLogic {
    
    var isRouteToChallengeEssentialInfoInputSceneCalled = false
    var isRouteToChallengeConfirmSceneCalled = false
    var isRouteToPraiseSendSceneCalled = false
    var isRouteToChallengeCertificateSceneCalled = false
    var isRouteToNudgeSendSceneCalled = false
    var isRouteToChallengeHistorySceneCalled = false
    var isRouteToGuideSceneCalled = false
    
    var lastEntryPoint: String?
    
    func routeToChallengeEssentialInfoInputScene() {
        self.isRouteToChallengeEssentialInfoInputSceneCalled = true
    }
    
    func routeToChallengeConfirmScene(entryPoint: String) {
        self.isRouteToChallengeConfirmSceneCalled = true
        self.lastEntryPoint = entryPoint
    }
    
    func routeToPraiseSendScene() {
        self.isRouteToPraiseSendSceneCalled = true
    }
    
    func routeToChallengeCertificateScene() {
        self.isRouteToChallengeCertificateSceneCalled = true
    }
    
    func routeToNudgeSendScene() {
        self.isRouteToNudgeSendSceneCalled = true
    }
    
    func routeToChallengeHistoryScene() {
        self.isRouteToChallengeHistorySceneCalled = true
    }
    
    func routeToGuideScene() {
        self.isRouteToGuideSceneCalled = true
    }
}
