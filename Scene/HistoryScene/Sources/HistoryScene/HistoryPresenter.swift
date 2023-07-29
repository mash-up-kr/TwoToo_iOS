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
            let partnerFlower = FlowerMappingWorker(flowerType: $0.partnerInfo.flower).getSmallImage()
            let myFlower = FlowerMappingWorker(flowerType: $0.myInfo.flower).getSmallImage()
            let cellInfo = History.ViewModel.CellInfo(orderText: "\($0.order)번째 챌린지",
                                                      nameText: $0.name,
                                                      dateText: dateText,
                                                      partnerFlowerImage: partnerFlower,
                                                      myFlowerImage: myFlower)
            viewModel.append(cellInfo)
        }
        return viewModel
    }
    
}
