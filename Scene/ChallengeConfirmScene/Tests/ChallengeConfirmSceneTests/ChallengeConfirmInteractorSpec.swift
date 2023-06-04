import Foundation
import Quick
import Nimble
@testable import ChallengeConfirmScene

final class ChallengeConfirmInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ChallengeConfirmInteractor!
        var presenter: ChallengeConfirmPresenterMock!
        var worker: ChallengeConfirmWorkerMock!
        var router: ChallengeConfirmRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ChallengeConfirmPresenterMock()
            router = await ChallengeConfirmRouterMock()
            worker = ChallengeConfirmWorkerMock()
            
            interactor = ChallengeConfirmInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class ChallengeConfirmPresenterMock: ChallengeConfirmPresentationLogic {
    
}

class ChallengeConfirmWorkerMock: ChallengeConfirmWorkerProtocol {
    
}

class ChallengeConfirmRouterMock: ChallengeConfirmRoutingLogic {
    
}
