import Foundation
import Quick
import Nimble
@testable import ChallengeHistoryDetailScene

final class ChallengeHistoryDetailInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ChallengeHistoryDetailInteractor!
        var presenter: ChallengeHistoryDetailPresenterMock!
        var worker: ChallengeHistoryDetailWorkerMock!
        var router: ChallengeHistoryDetailRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ChallengeHistoryDetailPresenterMock()
            router = await ChallengeHistoryDetailRouterMock()
            worker = ChallengeHistoryDetailWorkerMock()
            
            interactor = ChallengeHistoryDetailInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class ChallengeHistoryDetailPresenterMock: ChallengeHistoryDetailPresentationLogic {
    
}

class ChallengeHistoryDetailWorkerMock: ChallengeHistoryDetailWorkerProtocol {
    
}

class ChallengeHistoryDetailRouterMock: ChallengeHistoryDetailRoutingLogic {
    
}
