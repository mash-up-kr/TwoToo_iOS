import Foundation
import Quick
import Nimble
@testable import ChallengeCreateFinishScene

final class ChallengeCreateFinishInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ChallengeCreateFinishInteractor!
        var presenter: ChallengeCreateFinishPresenterMock!
        var worker: ChallengeCreateFinishWorkerMock!
        var router: ChallengeCreateFinishRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ChallengeCreateFinishPresenterMock()
            router = await ChallengeCreateFinishRouterMock()
            worker = ChallengeCreateFinishWorkerMock()
            
            interactor = ChallengeCreateFinishInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class ChallengeCreateFinishPresenterMock: ChallengeCreateFinishPresentationLogic {
    
}

class ChallengeCreateFinishWorkerMock: ChallengeCreateFinishWorkerProtocol {
    
}

class ChallengeCreateFinishRouterMock: ChallengeCreateFinishRoutingLogic {
    
}
