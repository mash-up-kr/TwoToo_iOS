import Combine
import Foundation
import Quick
import Nimble
@testable import HomeScene

final class ChallengeBeforeStartMappingSpec: QuickSpec {
    
    override func spec() {
        var model: Home.Model.Challenge!
        var viewModel: Home.ViewModel.ChallengeBeforeStartViewModel!
        
        describe("내 닉네임") {
            describe("내 정보의 닉네임이 “Test” 이다.") {
                beforeEach {
                    model = .default()
                    model.myInfo.nickname = "Test"
                    
                    viewModel = model.toChallengeBeforeStartViewModel()
                }
                
                it("내 이름 텍스트가 “Test” 로 표현된다.") {
                    expect(viewModel.myNameText).to(equal("Test"))
                }
            }
            
            describe("내 정보의 닉네임이 “Test-2” 이다.") {
                beforeEach {
                    model = .default()
                    model.myInfo.nickname = "Test-2"
                    
                    viewModel = model.toChallengeBeforeStartViewModel()
                }
                
                it("내 이름 텍스트가 “Test-2” 로 표현된다.") {
                    expect(viewModel.myNameText).to(equal("Test-2"))
                }
            }
        }
        
        describe("상대방 닉네임") {
            describe("상대방 정보의 닉네임이 “Test” 이다.") {
                beforeEach {
                    model = .default()
                    model.partnerInfo.nickname = "Test"
                    
                    viewModel = model.toChallengeBeforeStartViewModel()
                }
                
                it("상대방 이름 텍스트가 “Test” 로 표현된다.") {
                    expect(viewModel.partnerNameText).to(equal("Test"))
                }
                
                it("타이틀이  “Test님이 보낸 \n챌린지를 확인해주세요” 로 표현된다.") {
                    expect(viewModel.title.string).to(equal("Test님이 보낸 \n챌린지를 확인해주세요"))
                }
            }
            
            describe("상대방 정보의 닉네임이 “Test-2” 이다.") {
                beforeEach {
                    model = .default()
                    model.partnerInfo.nickname = "Test-2"
                    
                    viewModel = model.toChallengeBeforeStartViewModel()
                }
                
                it("상대방 이름 텍스트가 “Test-2” 로 표현된다.") {
                    expect(viewModel.partnerNameText).to(equal("Test-2"))
                }
                
                it("타이틀이  “Test-2님이 보낸 \n챌린지를 확인해주세요” 로 표현된다.") {
                    expect(viewModel.title.string).to(equal("Test-2님이 보낸 \n챌린지를 확인해주세요"))
                }
            }
        }
    }
}
