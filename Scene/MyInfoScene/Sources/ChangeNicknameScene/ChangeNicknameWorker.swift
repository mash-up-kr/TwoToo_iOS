//
//  ChangeNicknameWorker.swift
//  
//
//  Created by Eddy on 2023/10/12.
//

import CoreKit

protocol ChangeNicknameWorkerProtocol {
  func requestChangeNickname(name: String) async throws
}

final class ChangeNicknameWorker: ChangeNicknameWorkerProtocol {
  
  var meLocalWorker: MeLocalWorkerProtocol
  var changeNicknameNetworkWorker: ChangeNicknameNetworkWorkerProtocol
  
  init(
    meLocalWorker: MeLocalWorkerProtocol,
    changeNicknameNetworkWorker: ChangeNicknameNetworkWorkerProtocol
  ) {
    self.meLocalWorker = meLocalWorker
    self.changeNicknameNetworkWorker = changeNicknameNetworkWorker
  }
  
  func requestChangeNickname(name: String) async throws {
    _ = try await self.changeNicknameNetworkWorker.requestChangeNicknameInquiry(nickname: name)
    
  }
}
