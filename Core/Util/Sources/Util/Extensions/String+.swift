//
//  String+.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public extension String {

    func format(_ type: DateFormatType) -> String {
        let dateData = fullStringDate(type)
        Formatter.shared.dateFormat = type.displayName
        let dateString = Formatter.shared.string(from: dateData)
        return dateString
    }

    func fullStringDate(_ type: DateFormatType = .yearMonthDay) -> Date {
        var formatString: String {
            switch type {
            case .yearMonthDay, .hourMinute:
                return "yyyy-MM-dd'T'HH:mm:ss"
            }
        }

        Formatter.shared.dateFormat = formatString

        guard let dateData = Formatter.shared.date(from: self) else {
            return Date()
        }
        return dateData
    }
}
