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
    
    public let challengeID: String
    
    public init(challengeID: String) {
        self.challengeID = challengeID
    }
}

public final class ChallengeCertificateSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeCertificateConfiguration) -> ChallengeCertificateScene {
        
        let commitNetworkWorker = CommitNetworkWorker()
        
        let presenter = ChallengeCertificatePresenter()
        let router = ChallengeCertificateRouter()
        let worker = ChallengeCertificateWorker(
            commitNetworkWorker: commitNetworkWorker
        )
        let interactor = ChallengeCertificateInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            challengeID: configuration.challengeID
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
