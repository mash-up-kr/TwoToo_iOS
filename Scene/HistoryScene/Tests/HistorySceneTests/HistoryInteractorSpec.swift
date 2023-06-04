import Foundation
import Quick
import Nimble
@testable import HistoryScene

final class HistoryInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: HistoryInteractor!
        var presenter: HistoryPresenterMock!
        var worker: HistoryWorkerMock!
        var router: HistoryRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await HistoryPresenterMock()
            router = await HistoryRouterMock()
            worker = HistoryWorkerMock()
            
            interactor = HistoryInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class HistoryPresenterMock: HistoryPresentationLogic {
    
}

class HistoryWorkerMock: HistoryWorkerProtocol {
    
}

class HistoryRouterMock: HistoryRoutingLogic {
    
}
