import Foundation
import Quick
import Nimble
@testable import InvitationSendScene

final class InvitationSendInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: InvitationSendInteractor!
        var presenter: InvitationSendPresenterMock!
        var worker: InvitationSendWorkerMock!
        var router: InvitationSendRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await InvitationSendPresenterMock()
            router = await InvitationSendRouterMock()
            worker = InvitationSendWorkerMock()
            
            interactor = InvitationSendInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class InvitationSendPresenterMock: InvitationSendPresentationLogic {
    
}

class InvitationSendWorkerMock: InvitationSendWorkerProtocol {
    
}

class InvitationSendRouterMock: InvitationSendRoutingLogic {
    
}
