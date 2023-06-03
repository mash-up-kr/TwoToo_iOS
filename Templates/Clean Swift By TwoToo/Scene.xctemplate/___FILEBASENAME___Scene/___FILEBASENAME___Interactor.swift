//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ TwoToo. All rights reserved.
//

import CoreKit

protocol ___VARIABLE_sceneName___BusinessLogic {}

protocol ___VARIABLE_sceneName___DataStore: AnyObject {}

final class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___DataStore, ___VARIABLE_sceneName___BusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ___VARIABLE_sceneName___PresentationLogic
    var router: ___VARIABLE_sceneName___RoutingLogic
    var worker: ___VARIABLE_sceneName___WorkerProtocol
    
    init(
        presenter: ___VARIABLE_sceneName___PresentationLogic,
        router: ___VARIABLE_sceneName___RoutingLogic,
        worker: ___VARIABLE_sceneName___WorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ___VARIABLE_sceneName___Interactor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ___VARIABLE_sceneName___Interactor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ___VARIABLE_sceneName___Interactor {
    
}
