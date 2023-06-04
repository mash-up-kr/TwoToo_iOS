import Foundation
import Quick
import Nimble
@testable import PraiseSendScene

final class PraiseSendInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: PraiseSendInteractor!
        var presenter: PraiseSendPresenterMock!
        var worker: PraiseSendWorkerMock!
        var router: PraiseSendRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await PraiseSendPresenterMock()
            router = await PraiseSendRouterMock()
            worker = PraiseSendWorkerMock()
            
            interactor = PraiseSendInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class PraiseSendPresenterMock: PraiseSendPresentationLogic {
    
}

class PraiseSendWorkerMock: PraiseSendWorkerProtocol {
    
}

class PraiseSendRouterMock: PraiseSendRoutingLogic {
    
}
