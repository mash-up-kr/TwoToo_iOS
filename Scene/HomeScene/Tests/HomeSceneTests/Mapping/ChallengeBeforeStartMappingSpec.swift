import Combine
import Foundation
import Quick
import Nimble
@testable import HomeScene

final class ChallengeBeforeStartMappingSpec: QuickSpec {
    
    override func spec() {
        describe("ChallengeBeforeStartViewModel") {
            var model: Home.Model.Challenge!
            var viewModel: Home.ViewModel.ChallengeBeforeStartViewModel!
            
            beforeEach {
                model = Home.Model.Challenge(
                    id: "challengeId",
                    name: "Test",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                    order: 0,
                    status: .beforeStart,
                    myInfo: Home.Model.User(id: "userId", nickname: "Test"),
                    partnerInfo: Home.Model.User(id: "partnerId", nickname: "Test"),
                    stickRemaining: 0
                )
                
                viewModel = model.toChallengeBeforeStartViewModel()
            }
            
            context("내 닉네임") {
                it("내 이름 텍스트가 “Test” 로 표현된다.") {
                    expect(viewModel.myNameText).to(equal("Test"))
                }
            }
            
            context("상대방 닉네임") {
                it("상대방 이름 텍스트가 “Test” 로 표현된다.") {
                    expect(viewModel.partnerNameText).to(equal("Test"))
                }
                
                it("타이틀이  “Test님이 보낸 \n챌린지를 확인해주세요” 로 표현된다.") {
                    expect(viewModel.title.string).to(equal("Test님이 보낸 \n챌린지를 확인해주세요"))
                }
            }
        }
    }
}
