import Foundation
import Quick
import Nimble
@testable import HomeScene

final class HomeInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: HomeInteractor!
        var presenter: HomePresenterMock!
        var worker: HomeWorkerMock!
        var router: HomeRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await HomePresenterMock()
            router = await HomeRouterMock()
            worker = HomeWorkerMock()
            
            interactor = HomeInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class HomePresenterMock: HomePresentationLogic {
    
}

class HomeWorkerMock: HomeWorkerProtocol {
    
}

class HomeRouterMock: HomeRoutingLogic {
    
}
