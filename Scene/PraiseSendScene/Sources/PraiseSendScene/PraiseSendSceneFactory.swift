//
//  PraiseSendSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

@MainActor
public protocol PraiseSendScene: AnyObject, Scene {
    var bottomSheetViewController: UIViewController { get }
}

public struct PraiseSendConfiguration {
    
    public let certificateID: String
    
    public init(certificateID: String) {
        self.certificateID = certificateID
    }
}

public final class PraiseSendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: PraiseSendConfiguration) -> PraiseSendScene {
        
        let commentNetworkWorker = CommentNetworkWorker()
        
        let presenter = PraiseSendPresenter()
        let router = PraiseSendRouter()
        let worker = PraiseSendWorker(commentNetworkWorker: commentNetworkWorker)
        let interactor = PraiseSendInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            certificateID: configuration.certificateID
        )
        let viewController = PraiseSendViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
