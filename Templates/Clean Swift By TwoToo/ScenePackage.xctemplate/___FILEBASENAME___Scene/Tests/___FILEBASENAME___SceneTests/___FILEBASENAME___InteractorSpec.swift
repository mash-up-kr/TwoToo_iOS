import Foundation
import Quick
import Nimble
@testable import ___VARIABLE_sceneName___Scene

final class ___VARIABLE_sceneName___InteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ___VARIABLE_sceneName___Interactor!
        var presenter: ___VARIABLE_sceneName___PresenterMock!
        var worker: ___VARIABLE_sceneName___WorkerMock!
        var router: ___VARIABLE_sceneName___RouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ___VARIABLE_sceneName___PresenterMock()
            router = await ___VARIABLE_sceneName___RouterMock()
            worker = ___VARIABLE_sceneName___WorkerMock()
            
            interactor = ___VARIABLE_sceneName___Interactor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class ___VARIABLE_sceneName___PresenterMock: ___VARIABLE_sceneName___PresentationLogic {
    
}

class ___VARIABLE_sceneName___WorkerMock: ___VARIABLE_sceneName___WorkerProtocol {
    
}

class ___VARIABLE_sceneName___RouterMock: ___VARIABLE_sceneName___RoutingLogic {
    
}
