//
//  HistoryPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import Util
import Worker

@MainActor
protocol HistoryPresentationLogic {
    /// 히스토리 챌린지 리스트를 보여준다.
    func presentHistoryChallengeList(model: History.Model.ChallengeList)
    /// Empty 화면을 보여준다.
    func presentEmpty()
    /// 히스토리 조회 오류 화면을 보여준다.
    func presentHistoryError(model: Error)
}

final class HistoryPresenter {
    weak var viewController: HistoryDisplayLogic?
}

// MARK: - Presentation Logic

extension HistoryPresenter: HistoryPresentationLogic {
    func presentHistoryChallengeList(model: History.Model.ChallengeList) {
        let viewModel = self.map(model: model)
        self.viewController?.displayChallengeList(viewModel: viewModel)
    }
    
    func presentEmpty() {
        self.viewController?.displayChallengeEmptyView()
    }
    
    func presentHistoryError(model: Error) {
        self.viewController?.displayToast(viewModel: .init(message: History.Model.ErrorToast.message))
    }
    
}

private extension HistoryPresenter {
    
    func map(model: History.Model.ChallengeList) -> History.ViewModel.CellInfoList {
        var viewModel: History.ViewModel.CellInfoList = []
        model.forEach {
            let start: String = $0.startDate.dateToString(.shortYearMonthDay)
            let end: String = $0.endDate.dateToString(.shortYearMonthDay)
            let dateText: String = start + " ~ " + end
            var partnerFlower: UIImage?
            var orderText = ""
            if let partnerInfoFlower = $0.partnerFlower {
                partnerFlower = FlowerMappingWorker(flowerType: partnerInfoFlower).getSmallImage()
            }
            else {
                partnerFlower = .asset(.img_buds)
            }
            var myFlower: UIImage?
            if let myInfoFlower = $0.myFlower {
                myFlower = FlowerMappingWorker(flowerType: myInfoFlower).getSmallImage()
            }
            else {
                myFlower = .asset(.img_buds)
            }
            
            if $0.viewState == "Finished" {
              orderText = "\($0.order)번째 챌린지"
            }
            else {
              orderText = "\($0.order)번째 챌린지 중"
            }
          
            let cellInfo = History.ViewModel.CellInfo(orderText: orderText,
                                                      nameText: $0.name,
                                                      dateText: dateText,
                                                      partnerFlowerImage: partnerFlower,
                                                      myFlowerImage: myFlower)
            viewModel.append(cellInfo)
        }
        return viewModel
    }
    
}
