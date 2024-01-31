import Foundation
import Quick
import Nimble
@testable import HomeScene

final class ChallengeCompletedMappingSpec: QuickSpec {
    
    override func spec() {
        describe("ChallengeCompletedViewModel") {
            var model: Home.Model.Challenge!
            var viewModel: Home.ViewModel.ChallengeCompletedViewModel!
            
            beforeEach {
                var tomorrowComponents = DateComponents()
                tomorrowComponents.day = -1
                
                model = Home.Model.Challenge(
                    id: "challengeId",
                    name: "Test",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: tomorrowComponents, to: Date()),
                    order: 2,
                    status: .completed(.comfirmed),
                    myInfo: Home.Model.User(
                        id: "userId",
                        nickname: "Test",
                        certCount: 1
                    ),
                    partnerInfo: Home.Model.User(
                        id: "partnerId",
                        nickname: "Test",
                        certCount: 1
                    ),
                    stickRemaining: 0
                )
                
                viewModel = model.toChallengeCompletedViewModel()
            }
            
            context("챌린지 이름") {
                it("챌린지 정보의 챌린지 이름 텍스트가 'Test'로 표현된다.") {
                    expect(viewModel.challengeInfo.challengeNameText).to(equal("Test"))
                }
            }
            
            context("챌린지 순서") {
                it("순서의 챌린지 순서 텍스트가 '2번째 챌린지 중'로 표현된다.") {
                    expect(viewModel.order.challengeOrderText).to(equal("2번째 챌린지 중"))
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
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.myPercentageText).to(equal("99%"))
                }
                
                it("프로그래스의 내 퍼센테이지 넘버가 0.99로 표현된다.") {
                    model.myInfo.certCount = 20
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.myPercentageNumber).to(beCloseTo(0.99, within: 0.001))
                }
                
                it("프로그래스의 내 퍼센테이지 텍스트가 '100%'로 표현된다.") {
                    model.myInfo.certCount = 22
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.myPercentageText).to(equal("100%"))
                }
                
                it("프로그래스의 내 퍼센테이지 넘버가 1로 표현된다.") {
                    model.myInfo.certCount = 22
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.myPercentageNumber).to(equal(1))
                }
            }
            
            context("내 성장도") {
                it("내 꽃의 꽃 이름 히든 여부가 true 로 표현된다.") {
                    model.myInfo.growStatus = .seed
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.myFlower.isFlowerLanguageBubbleHidden).to(beTrue())
                }
                
                it("내 꽃의 꽃 이름 히든 여부가 true 로 표현된다.") {
                    model.myInfo.growStatus = .sprout
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.myFlower.isFlowerLanguageBubbleHidden).to(beTrue())
                }
                
                it("내 꽃의 꽃 이름 히든 여부가 true 로 표현된다.") {
                    model.myInfo.growStatus = .peak
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.myFlower.isFlowerLanguageBubbleHidden).to(beTrue())
                }
                
                it("내 꽃의 꽃 이름 히든 여부가 false 로 표현된다.") {
                    model.myInfo.growStatus = .flower
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.myFlower.isFlowerLanguageBubbleHidden).to(beFalse())
                }
                
                it("내 꽃의 꽃 이름 히든 여부가 false 로 표현된다.") {
                    model.myInfo.growStatus = .bloom
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.myFlower.isFlowerLanguageBubbleHidden).to(beFalse())
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
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.partnerPercentageText).to(equal("99%"))
                }
                
                it("프로그래스의 상대방 퍼센테이지 넘버가 0.99로 표현된다.") {
                    model.partnerInfo.certCount = 20
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.partnerPercentageNumber).to(beCloseTo(0.99, within: 0.001))
                }
                
                it("프로그래스의 상대방 퍼센테이지 텍스트가 '100%'로 표현된다.") {
                    model.partnerInfo.certCount = 22
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.partnerPercentageText).to(equal("100%"))
                }
                
                it("프로그래스의 상대방 퍼센테이지 넘버가 1로 표현된다.") {
                    model.partnerInfo.certCount = 22
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.progress.partnerPercentageNumber).to(equal(1))
                }
            }
            
            context("상대방 성장도") {
                it("상대방 꽃의 꽃 이름 히든 여부가 true 로 표현된다.") {
                    model.partnerInfo.growStatus = .seed
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.partnerFlower.isFlowerLanguageBubbleHidden).to(beTrue())
                }
                
                it("상대방 꽃의 꽃 이름 히든 여부가 true 로 표현된다.") {
                    model.partnerInfo.growStatus = .sprout
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.partnerFlower.isFlowerLanguageBubbleHidden).to(beTrue())
                }
                
                it("상대방 꽃의 꽃 이름 히든 여부가 true 로 표현된다.") {
                    model.partnerInfo.growStatus = .peak
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.partnerFlower.isFlowerLanguageBubbleHidden).to(beTrue())
                }
                
                it("상대방 꽃의 꽃 이름 히든 여부가 false 로 표현된다.") {
                    model.partnerInfo.growStatus = .flower
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.partnerFlower.isFlowerLanguageBubbleHidden).to(beFalse())
                }
                
                it("상대방 꽃의 꽃 이름 히든 여부가 false 로 표현된다.") {
                    model.partnerInfo.growStatus = .bloom
                    viewModel = model.toChallengeCompletedViewModel()
                    expect(viewModel.partnerFlower.isFlowerLanguageBubbleHidden).to(beFalse())
                }
            }
        }
    }
}
