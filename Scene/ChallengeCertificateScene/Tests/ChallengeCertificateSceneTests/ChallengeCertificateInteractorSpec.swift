import Foundation
import Quick
import Nimble
@testable import ChallengeCertificateScene

final class ChallengeCertificateInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ChallengeCertificateInteractor!
        var presenter: ChallengeCertificatePresenterMock!
        var worker: ChallengeCertificateWorkerMock!
        var router: ChallengeCertificateRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ChallengeCertificatePresenterMock()
            router = await ChallengeCertificateRouterMock()
            worker = ChallengeCertificateWorkerMock()
            
            interactor = ChallengeCertificateInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class ChallengeCertificatePresenterMock: ChallengeCertificatePresentationLogic {
    
}

class ChallengeCertificateWorkerMock: ChallengeCertificateWorkerProtocol {
    
}

class ChallengeCertificateRouterMock: ChallengeCertificateRoutingLogic {
    
}
