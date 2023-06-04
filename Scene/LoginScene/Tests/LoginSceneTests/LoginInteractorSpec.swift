import Foundation
import Quick
import Nimble
@testable import LoginScene

final class LoginInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: LoginInteractor!
        var presenter: LoginPresenterMock!
        var worker: LoginWorkerMock!
        var router: LoginRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await LoginPresenterMock()
            router = await LoginRouterMock()
            worker = LoginWorkerMock()
            
            interactor = LoginInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class LoginPresenterMock: LoginPresentationLogic {
    
}

class LoginWorkerMock: LoginWorkerProtocol {
    
}

class LoginRouterMock: LoginRoutingLogic {
    
}
