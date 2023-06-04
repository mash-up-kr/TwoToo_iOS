import Foundation
import Quick
import Nimble
@testable import MyInfoScene

final class MyInfoInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: MyInfoInteractor!
        var presenter: MyInfoPresenterMock!
        var worker: MyInfoWorkerMock!
        var router: MyInfoRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await MyInfoPresenterMock()
            router = await MyInfoRouterMock()
            worker = MyInfoWorkerMock()
            
            interactor = MyInfoInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class MyInfoPresenterMock: MyInfoPresentationLogic {
    
}

class MyInfoWorkerMock: MyInfoWorkerProtocol {
    
}

class MyInfoRouterMock: MyInfoRoutingLogic {
    
}
