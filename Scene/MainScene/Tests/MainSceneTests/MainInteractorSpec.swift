import Foundation
import Quick
import Nimble
@testable import MainScene

final class MainInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: MainInteractor!
        var presenter: MainPresenterMock!
        var worker: MainWorkerMock!
        var router: MainRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await MainPresenterMock()
            router = await MainRouterMock()
            worker = MainWorkerMock()
            
            interactor = MainInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class MainPresenterMock: MainPresentationLogic {
    
}

class MainWorkerMock: MainWorkerProtocol {
    
}

class MainRouterMock: MainRoutingLogic {
    
}
