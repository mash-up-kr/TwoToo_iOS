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
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class ChallengeHistoryPresenterMock: ChallengeHistoryPresentationLogic {
    
}

class ChallengeHistoryWorkerMock: ChallengeHistoryWorkerProtocol {
    
}

class ChallengeHistoryRouterMock: ChallengeHistoryRoutingLogic {
    
}
