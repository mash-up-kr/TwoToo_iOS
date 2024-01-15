import Foundation
import Quick
import Nimble
@testable import HomeScene

final class ChallengeInProgressMappingSpec: QuickSpec {

    override func spec() {
        describe("ChallengeInProgressViewModel") {
            var model: Home.Model.Challenge!
            var viewModel: Home.ViewModel.ChallengeInProgressViewModel!

            beforeEach {
                var tomorrowComponents = DateComponents()
                tomorrowComponents.day = 1
                tomorrowComponents.second = 10
                
                model = Home.Model.Challenge(
                    id: "challengeId",
                    name: "Test",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: tomorrowComponents, to: Date()),
                    order: 1,
                    status: .inProgress(.bothUncertificated),
                    myInfo: Home.Model.User(
                        id: "userId",
                        nickname: "Test",
                        certCount: 1,
                        todayCert: .init(id: "certId", complimentComment: "Test")
                    ),
                    partnerInfo: Home.Model.User(
                        id: "partnerId",
                        nickname: "Test",
                        certCount: 1,
                        todayCert: .init(id: "certId", complimentComment: "Test")
                    ),
                    stickRemaining: 3
                )

                viewModel = model.toChallengeInProgressViewModel()
            }

            context("챌린지 이름") {
                it("챌린지 정보의 챌린지 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.challengeInfo.challengeNameText).to(equal("Test"))
                }
            }

            context("챌린지 종료일") {
                it("챌린지 정보의 디데이 텍스트가 'D-1'로 표현된다.") {
                    expect(viewModel.challengeInfo.dDayText).to(equal("D-1"))
                }
            }

            context("챌린지 순서") {
                it("순서의 챌린지 순서 텍스트가 '1번째 챌린지 중'로 표현된다.") {
                    expect(viewModel.order.challengeOrderText).to(equal("1번째 챌린지 중"))
                }
            }

            context("내 닉네임") {
                it("프로그래스의 내 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.progress.myNameText).to(equal("Test"))
                }

                it("순서의 내 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.order.myNameText).to(equal("Test"))
                }

                it("내 꽃의 내 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.myFlower.myNameText).to(equal("Test"))
                }
            }

            context("내 인증 횟수") {
                it("프로그래스의 내 퍼센테이지 텍스트가 '5%'로 표현된다.") {
                    expect(viewModel.progress.myPercentageText).to(equal("5%"))
                }

                it("프로그래스의 내 퍼센테이지 넘버가 0.05로 표현된다.") {
                    expect(viewModel.progress.myPercentageNumber).to(beCloseTo(0.05, within: 0.001))
                }

                it("프로그래스의 내 퍼센테이지 텍스트가 '99%'로 표현된다.") {
                    model.myInfo.certCount = 20
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.myPercentageText).to(equal("99%"))
                }

                it("프로그래스의 내 퍼센테이지 넘버가 0.99로 표현된다.") {
                    model.myInfo.certCount = 20
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.myPercentageNumber).to(beCloseTo(0.99, within: 0.001))
                }

                it("프로그래스의 내 퍼센테이지 텍스트가 '100%'로 표현된다.") {
                    model.myInfo.certCount = 22
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.myPercentageText).to(equal("100%"))
                }

                it("프로그래스의 내 퍼센테이지 넘버가 1로 표현된다.") {
                    model.myInfo.certCount = 22
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.myPercentageNumber).to(equal(1))
                }
            }

            context("내 성장도") {
                // 성장도 매핑 시나리오
            }

            context("내 칭찬 문구") {
                it("내 꽃의 칭찬 문구 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.complimentCommentText).to(equal("Test"))
                }
            }

            context("상대방 닉네임") {
                it("프로그래스의 상대방 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.progress.partnerNameText).to(equal("Test"))
                }

                it("순서의 상대방 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.order.partenrNameText).to(equal("Test"))
                }

                it("상대방 꽃의 상대방 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.partnerFlower.partnerNameText).to(equal("Test"))
                }
            }

            context("상대방 인증 횟수") {
                it("프로그래스의 상대방 퍼센테이지 텍스트가 '5%'로 표현된다.") {
                    expect(viewModel.progress.partnerPercentageText).to(equal("5%"))
                }

                it("프로그래스의 상대방 퍼센테이지 넘버가 0.05로 표현된다.") {
                    expect(viewModel.progress.partnerPercentageNumber).to(beCloseTo(0.05, within: 0.001))
                }

                it("프로그래스의 상대방 퍼센테이지 텍스트가 '99%'로 표현된다.") {
                    model.partnerInfo.certCount = 20
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.partnerPercentageText).to(equal("99%"))
                }

                it("프로그래스의 상대방 퍼센테이지 넘버가 0.99로 표현된다.") {
                    model.partnerInfo.certCount = 20
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.partnerPercentageNumber).to(beCloseTo(0.99, within: 0.001))
                }

                it("프로그래스의 상대방 퍼센테이지 텍스트가 '100%'로 표현된다.") {
                    model.partnerInfo.certCount = 22
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.partnerPercentageText).to(equal("100%"))
                }

                it("프로그래스의 상대방 퍼센테이지 넘버가 1로 표현된다.") {
                    model.partnerInfo.certCount = 22
                    viewModel = model.toChallengeInProgressViewModel()
                    expect(viewModel.progress.partnerPercentageNumber).to(equal(1))
                }
            }

            context("상대방 성장도") {
                // 성장도 매핑 시나리오를 작성해주세요.
            }

            context("상대방 칭찬 문구") {
                it("상대방 꽃의 칭찬 문구 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.complimentCommentText).to(equal("Test"))
                }
            }

            context("챌린지 진행 상태 > 둘다 인증전") {
                beforeEach {
                    model.status = .inProgress(.bothUncertificated)
                    viewModel = model.toChallengeInProgressViewModel()
                }

                it("내 꽃의 인증 버튼 히든 여부가 false로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isCertificationButtonHidden).to(beFalse())
                }

                it("상대방 꽃의 인증 완료 히든 여부가 true로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isCertificationCompleteHidden).to(beTrue())
                }

                it("내 꽃의 칭찬 문구 히든 여부가 true로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isComplimentCommentHidden).to(beTrue())
                }

                it("상대방 꽃의 칭찬 문구 히든 여부가 true로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isComplimentCommentHidden).to(beTrue())
                }

                it("하트 히든 여부가 true로 표현된다.") {
                    expect(viewModel.isHeartHidden).to(beTrue())
                }
            }

            context("챌린지 진행 상태 > 상대방만 인증") {
                beforeEach {
                    model.status = .inProgress(.onlyPartnerCertificated)
                    viewModel = model.toChallengeInProgressViewModel()
                }

                it("내 꽃의 인증 버튼 히든 여부가 false로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isCertificationButtonHidden).to(beFalse())
                }

                it("상대방 꽃의 인증 완료 히든 여부가 false로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isCertificationCompleteHidden).to(beFalse())
                }

                it("내 꽃의 칭찬 문구 히든 여부가 true로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isComplimentCommentHidden).to(beTrue())
                }

                it("상대방 꽃의 칭찬 문구 히든 여부가 true로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isComplimentCommentHidden).to(beTrue())
                }

                it("하트 히든 여부가 true로 표현된다.") {
                    expect(viewModel.isHeartHidden).to(beTrue())
                }
            }

            context("챌린지 진행 상태 > 나만 인증") {
                beforeEach {
                    model.status = .inProgress(.onlyMeCertificated)
                    viewModel = model.toChallengeInProgressViewModel()
                }

                it("내 꽃의 인증 버튼 히든 여부가 true로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isCertificationButtonHidden).to(beTrue())
                }

                it("상대방 꽃의 인증 완료 히든 여부가 true로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isCertificationCompleteHidden).to(beTrue())
                }

                it("내 꽃의 칭찬 문구 히든 여부가 true로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isComplimentCommentHidden).to(beTrue())
                }

                it("상대방 꽃의 칭찬 문구 히든 여부가 true로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isComplimentCommentHidden).to(beTrue())
                }

                it("하트 히든 여부가 true로 표현된다.") {
                    expect(viewModel.isHeartHidden).to(beTrue())
                }
            }

            context("챌린지 진행 상태 > 둘다 인증") {
                beforeEach {
                    model.status = .inProgress(.bothCertificated(.uncomfirmed))
                    viewModel = model.toChallengeInProgressViewModel()
                }

                it("내 꽃의 인증 버튼 히든 여부가 true로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isCertificationButtonHidden).to(beTrue())
                }

                it("상대방 꽃의 인증 완료 히든 여부가 true로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isCertificationCompleteHidden).to(beTrue())
                }

                it("내 꽃의 칭찬 문구 히든 여부가 false로 표현된다.") {
                    expect(viewModel.myFlower.topViewModel.isComplimentCommentHidden).to(beFalse())
                }

                it("상대방 꽃의 칭찬 문구 히든 여부가 false로 표현된다.") {
                    expect(viewModel.partnerFlower.topViewModel.isComplimentCommentHidden).to(beFalse())
                }

                it("하트 히든 여부가 false로 표현된다.") {
                    expect(viewModel.isHeartHidden).to(beFalse())
                }
            }

            context("찌르기 남은 횟수") {
                it("찌르기 텍스트가 '콕 찌르기 (3/3)'로 표현된다.") {
                    expect(viewModel.stickText).to(equal("콕 찌르기 (3/3)"))
                }
            }
        }
    }
}
