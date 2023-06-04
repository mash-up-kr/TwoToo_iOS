import Foundation
import Quick
import Nimble
@testable import SplashScene

final class SplashInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: SplashInteractor!
        var presenter: SplashPresenterMock!
        var worker: SplashWorkerMock!
        var router: SplashRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await SplashPresenterMock()
            router = await SplashRouterMock()
            worker = SplashWorkerMock()
            
            interactor = SplashInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class SplashPresenterMock: SplashPresentationLogic {
    
}

class SplashWorkerMock: SplashWorkerProtocol {
    
}

class SplashRouterMock: SplashRoutingLogic {
    
}
