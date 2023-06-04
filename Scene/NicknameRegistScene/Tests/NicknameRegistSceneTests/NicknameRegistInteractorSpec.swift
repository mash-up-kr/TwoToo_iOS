import Foundation
import Quick
import Nimble
@testable import NicknameRegistScene

final class NicknameRegistInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: NicknameRegistInteractor!
        var presenter: NicknameRegistPresenterMock!
        var worker: NicknameRegistWorkerMock!
        var router: NicknameRegistRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await NicknameRegistPresenterMock()
            router = await NicknameRegistRouterMock()
            worker = NicknameRegistWorkerMock()
            
            interactor = NicknameRegistInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
    }
}

class NicknameRegistPresenterMock: NicknameRegistPresentationLogic {
    
}

class NicknameRegistWorkerMock: NicknameRegistWorkerProtocol {
    
}

class NicknameRegistRouterMock: NicknameRegistRoutingLogic {
    
}
