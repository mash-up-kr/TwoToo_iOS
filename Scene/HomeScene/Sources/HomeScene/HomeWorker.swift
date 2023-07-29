//
//  HomeWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import Foundation
import CoreKit

protocol HomeWorkerProtocol {
    /// 챌린지 완료 확인 여부
    var challengeCompletedConfirmed: Bool { get set }
    /// 둘다 인증 확인 여부
    var bothCertificationConfirmed: Bool { get set }
    /// 홈 조회
    func fetchHomeInfo() async throws -> Home.Model.HomeInfo
    /// 챌린지 완료 요청
    func requestChallengeComplete(challengeID: String) async throws
}

final class HomeWorker: HomeWorkerProtocol {
    
    // TODO: UD에서 챌린지 완료 확인 여부를 업데이트 및 추출하는 작업 필요
    var challengeCompletedConfirmed: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    // TODO: UD에서 둘다 인증 확인 여부를 업데이트 및 추출하는 작업 필요
    var bothCertificationConfirmed: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    var mockCount: Int = 1
    
    func fetchHomeInfo() async throws -> Home.Model.HomeInfo {
        let challenge: Home.Model.Challenge = .mockForNumber(number: self.mockCount)
        self.mockCount += 1
        return .init(challenge: challenge)
    }
    
    func requestChallengeComplete(challengeID: String) async throws {
        
    }
}

extension Home.Model.Challenge {
    static func mockForNumber(number: Int) -> Home.Model.Challenge {
        switch number % 13 {
        case 1:
            return .mockCreated
        case 2:
            return .mockWaiting
        case 3:
            return .mockBeforeStart
        case 4:
            return .mockBeforeStartDate
        case 5:
            return .mockAfterStartDate
        case 6:
            return .mockInProgressBothUncertificated
        case 7:
            return .mockInProgressOnlyPartnerCertificated
        case 8:
            return .mockInProgressOnlyMeCertificated
        case 9:
            return .mockInProgressBothCertificatedUncomfirmed
        case 10:
            return .mockInProgressBothCertificatedComfirmed
        case 11:
            return .mockCompletedUncomfirmed
        case 12:
            return .mockCompletedUncomfirmedThank
        default:
            return .mockCompletedComfirmed
        }
    }

    static var mockCreated: Home.Model.Challenge {
        return .init(
            status: .created,
            myInfo: .init(
                id: "Test",
                nickname: "공주"
            ),
            partnerInfo: .init(
                id: "Test2",
                nickname: "왕자"
            )
        )
    }

    static var mockWaiting: Home.Model.Challenge {
        return .init(
            id: "1",
            name: "운동",
            startDate: Date().addingTimeInterval(3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 23),
            status: .waiting,
            myInfo: .init(
                id: "Test",
                nickname: "공주"
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                flower: .rose
            )
        )
    }
    
    static var mockBeforeStart: Home.Model.Challenge {
        return .init(
            id: "2",
            name: "운동",
            startDate: Date().addingTimeInterval(3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 23),
            status: .beforeStart,
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자"
            )
        )
    }
    
    static var mockBeforeStartDate: Home.Model.Challenge {
        return .init(
            id: "3",
            name: "운동",
            startDate: Date().addingTimeInterval(3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 23),
            status: .beforeStartDate,
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                flower: .rose
            )
        )
    }
    
    static var mockAfterStartDate: Home.Model.Challenge {
        return .init(
            id: "4",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 21),
            status: .afterStartDate,
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자"
            )
        )
    }

    static var mockInProgressBothUncertificated: Home.Model.Challenge {
        return .init(
            id: "5",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 21),
            order: 2,
            status: .inProgress(.bothUncertificated),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 1,
                growStatus: .seed,
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 1,
                growStatus: .seed,
                flower: .rose
            ),
            stickRemaining: 5
        )
    }
    
    static var mockInProgressOnlyPartnerCertificated: Home.Model.Challenge {
        return .init(
            id: "6",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 21),
            order: 2,
            status: .inProgress(.onlyPartnerCertificated),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 1,
                growStatus: .seed,
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 1,
                growStatus: .seed,
                todayCert: .init(id: "1"),
                flower: .rose
            ),
            stickRemaining: 5
        )
    }
    
    static var mockInProgressOnlyMeCertificated: Home.Model.Challenge {
        return .init(
            id: "7",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 21),
            order: 2,
            status: .inProgress(.onlyMeCertificated),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 1,
                growStatus: .seed,
                todayCert: .init(id: "1"),
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 1,
                growStatus: .seed,
                flower: .rose
            ),
            stickRemaining: 5
        )
    }
    
    static var mockInProgressBothCertificatedUncomfirmed: Home.Model.Challenge {
        return .init(
            id: "8",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 20),
            endDate: Date().addingTimeInterval(3600 * 24 * 2),
            order: 2,
            status: .inProgress(.bothCertificated(.uncomfirmed)),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 17,
                growStatus: .flower,
                todayCert: .init(id: "1"),
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 16,
                growStatus: .peak,
                todayCert: .init(id: "1"),
                flower: .rose
            ),
            stickRemaining: 5
        )
    }
    
    static var mockInProgressBothCertificatedComfirmed: Home.Model.Challenge {
        return .init(
            id: "9",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 1),
            endDate: Date().addingTimeInterval(3600 * 24 * 21),
            order: 2,
            status: .inProgress(.bothCertificated(.comfirmed)),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 1,
                growStatus: .seed,
                todayCert: .init(id: "1", complimentComment: "123"),
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 1,
                growStatus: .seed,
                todayCert: .init(id: "1", complimentComment: "123123212321"),
                flower: .rose
            ),
            stickRemaining: 5
        )
    }
    
    static var mockCompletedUncomfirmed: Home.Model.Challenge {
        return .init(
            id: "10",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 22),
            endDate: Date(),
            order: 2,
            status: .completed(.uncomfirmed),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 21,
                growStatus: .flower,
                todayCert: .init(id: "1", complimentComment: "123"),
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 22,
                growStatus: .bloom,
                todayCert: .init(id: "1", complimentComment: "1234"),
                flower: .rose
            )
        )
    }
    
    static var mockCompletedUncomfirmedThank: Home.Model.Challenge {
        return .init(
            id: "11",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 22),
            endDate: Date(),
            order: 2,
            status: .completed(.uncomfirmed),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 1,
                growStatus: .seed,
                todayCert: .init(id: "1", complimentComment: "123"),
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 2,
                growStatus: .seed,
                todayCert: .init(id: "1", complimentComment: "1234"),
                flower: .rose
            )
        )
    }
    
    static var mockCompletedComfirmed: Home.Model.Challenge {
        return .init(
            id: "12",
            name: "운동",
            startDate: Date().addingTimeInterval(-3600 * 24 * 22),
            endDate: Date(),
            order: 2,
            status: .completed(.comfirmed),
            myInfo: .init(
                id: "Test",
                nickname: "공주",
                certCount: 19,
                growStatus: .flower,
                todayCert: .init(id: "1", complimentComment: "123"),
                flower: .rose
            ),
            partnerInfo: .init(
                id: "Test",
                nickname: "왕자",
                certCount: 22,
                growStatus: .bloom,
                todayCert: .init(id: "1", complimentComment: "1234"),
                flower: .rose
            )
        )
    }
}
