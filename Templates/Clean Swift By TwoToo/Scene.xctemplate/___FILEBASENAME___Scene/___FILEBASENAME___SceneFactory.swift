//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ TwoToo. All rights reserved.
//

import ModuleKit

@MainActor
public protocol ___VARIABLE_sceneName___Scene: AnyObject, Scene {
    
}

public struct ___VARIABLE_sceneName___Configuration {
    
}

public final class ___VARIABLE_sceneName___SceneFactory {
    
    public init() {}
    
    public func make(with configuration: ___VARIABLE_sceneName___Configuration) -> ___VARIABLE_sceneName___Scene {
        
        let presenter = ___VARIABLE_sceneName___Presenter()
        let router = ___VARIABLE_sceneName___Router()
        let worker = ___VARIABLE_sceneName___Worker()
        let interactor = ___VARIABLE_sceneName___Interactor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = ___VARIABLE_sceneName___ViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
