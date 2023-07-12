//
//  ChallengeCertificateSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

@MainActor
public protocol ChallengeCertificateScene: AnyObject, Scene {
    var bottomSheetViewController: UIViewController { get }
}

public struct ChallengeCertificateConfiguration {
    
    public init() {}
}

public final class ChallengeCertificateSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeCertificateConfiguration) -> ChallengeCertificateScene {
        
        let presenter = ChallengeCertificatePresenter()
        let router = ChallengeCertificateRouter()
        let worker = ChallengeCertificateWorker()
        let interactor = ChallengeCertificateInteractor(
            presenter: presenter,
            router: router,
            worker: worker
        )
        let viewController = ChallengeCertificateViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
