import Foundation
import Quick
import Nimble
@testable import FlowerSelectScene

final class FlowerSelectInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: FlowerSelectInteractor!
        var presenter: FlowerSelectPresenterMock!
        var worker: FlowerSelectWorkerMock!
        var router: FlowerSelectRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await FlowerSelectPresenterMock()
            router = await FlowerSelectRouterMock()
            worker = FlowerSelectWorkerMock()
            
            interactor = FlowerSelectInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class FlowerSelectPresenterMock: FlowerSelectPresentationLogic {
    
}

class FlowerSelectWorkerMock: FlowerSelectWorkerProtocol {
    
}

class FlowerSelectRouterMock: FlowerSelectRoutingLogic {
    
}
