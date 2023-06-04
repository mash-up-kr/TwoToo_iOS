import Foundation
import Quick
import Nimble
@testable import NudgeSendScene

final class NudgeSendInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: NudgeSendInteractor!
        var presenter: NudgeSendPresenterMock!
        var worker: NudgeSendWorkerMock!
        var router: NudgeSendRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await NudgeSendPresenterMock()
            router = await NudgeSendRouterMock()
            worker = NudgeSendWorkerMock()
            
            interactor = NudgeSendInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class NudgeSendPresenterMock: NudgeSendPresentationLogic {
    
}

class NudgeSendWorkerMock: NudgeSendWorkerProtocol {
    
}

class NudgeSendRouterMock: NudgeSendRoutingLogic {
    
}
