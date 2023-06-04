import Foundation
import Quick
import Nimble
@testable import InvitationWaitScene

final class InvitationWaitInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: InvitationWaitInteractor!
        var presenter: InvitationWaitPresenterMock!
        var worker: InvitationWaitWorkerMock!
        var router: InvitationWaitRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await InvitationWaitPresenterMock()
            router = await InvitationWaitRouterMock()
            worker = InvitationWaitWorkerMock()
            
            interactor = InvitationWaitInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class InvitationWaitPresenterMock: InvitationWaitPresentationLogic {
    
}

class InvitationWaitWorkerMock: InvitationWaitWorkerProtocol {
    
}

class InvitationWaitRouterMock: InvitationWaitRoutingLogic {
    
}
