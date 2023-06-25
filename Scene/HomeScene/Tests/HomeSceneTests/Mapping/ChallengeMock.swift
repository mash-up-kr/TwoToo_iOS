import Foundation
@testable import HomeScene

extension Home.Model.Challenge {
    
    static func `default`() -> Home.Model.Challenge {
        return .init(
            status: .afterStartDate,
            myInfo: .init(id: "", nickname: ""),
            partnerInfo: .init(id: "", nickname: "")
        )
    }
}
