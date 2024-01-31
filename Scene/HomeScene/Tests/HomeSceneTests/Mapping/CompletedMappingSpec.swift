import Combine
import Foundation
import Quick
import Nimble
@testable import HomeScene

final class CompletedMappingSpec: QuickSpec {
    
    override func spec() {
        describe("CompletedViewModel") {
            var model: Home.Model.Challenge!
            var viewModel: Home.ViewModel.ChallengeCompletedViewModel.CompletedPopupViewModel!
            
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
                        certCount: 1,
                        growStatus: .bloom
                    ),
                    partnerInfo: Home.Model.User(
                        id: "partnerId",
                        nickname: "Test",
                        certCount: 1,
                        growStatus: .flower
                    ),
                    stickRemaining: 0
                )
                
                viewModel = model.toCompletedViewModel()
            }
            
            context("성장도") {
                it("상대방 정보의 성장도가 씨앗일 때, 타이틀이 “수고했어요!”, 메세지가 “챌린지가 끝났어요!\n서로의 달성률을 확인해보세요” 로 표현된다.") {
                    model.partnerInfo.growStatus = .seed
                    viewModel = model.toCompletedViewModel()
                    expect(viewModel.show?.title).to(equal("수고했어요!"))
                    expect(viewModel.show?.message).to(equal("챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"))
                }
                
                it("상대방 정보의 성장도가 새싹일 때, 타이틀이 “수고했어요!”, 메세지가 “챌린지가 끝났어요!\n서로의 달성률을 확인해보세요” 로 표현된다.") {
                    model.partnerInfo.growStatus = .sprout
                    viewModel = model.toCompletedViewModel()
                    expect(viewModel.show?.title).to(equal("수고했어요!"))
                    expect(viewModel.show?.message).to(equal("챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"))
                }
                
                it("상대방 정보의 성장도가 봉우리일 때, 타이틀이 “수고했어요!”, 메세지가 “챌린지가 끝났어요!\n서로의 달성률을 확인해보세요” 로 표현된다.") {
                    model.partnerInfo.growStatus = .peak
                    viewModel = model.toCompletedViewModel()
                    expect(viewModel.show?.title).to(equal("수고했어요!"))
                    expect(viewModel.show?.message).to(equal("챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"))
                }
                
                it("내 정보의 성장도가 씨앗일 때, 타이틀이 “수고했어요!”, 메세지가 “챌린지가 끝났어요!\n서로의 달성률을 확인해보세요” 로 표현된다.") {
                    model.myInfo.growStatus = .seed
                    viewModel = model.toCompletedViewModel()
                    expect(viewModel.show?.title).to(equal("수고했어요!"))
                    expect(viewModel.show?.message).to(equal("챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"))
                }
                
                it("내 정보의 성장도가 새싹일 때, 타이틀이 “수고했어요!”, 메세지가 “챌린지가 끝났어요!\n서로의 달성률을 확인해보세요” 로 표현된다.") {
                    model.myInfo.growStatus = .sprout
                    viewModel = model.toCompletedViewModel()
                    expect(viewModel.show?.title).to(equal("수고했어요!"))
                    expect(viewModel.show?.message).to(equal("챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"))
                }
                
                it("내 정보의 성장도가 봉우리일 때, 타이틀이 “수고했어요!”, 메세지가 “챌린지가 끝났어요!\n서로의 달성률을 확인해보세요” 로 표현된다.") {
                    model.myInfo.growStatus = .peak
                    viewModel = model.toCompletedViewModel()
                    expect(viewModel.show?.title).to(equal("수고했어요!"))
                    expect(viewModel.show?.message).to(equal("챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"))
                }
                
                it("상대방과 내 정보의 성장도가 둘 다 꽃 혹은 만개한 꽃일 때, 타이틀이 “축하합니다!”, 메세지가 “둘다 꽃을 피웠어요!\n서로의 꽃을 확인해보세요!” 로 표현된다.") {
                    expect(viewModel.show?.title).to(equal("축하합니다!"))
                    expect(viewModel.show?.message).to(equal("둘다 꽃을 피웠어요!\n서로의 꽃을 확인해보세요!"))
                }
            }
        }
    }
}
