//
//  DateFormatter.swift
//  
//
//  Created by Eddy on 2023/06/08.
//


/*
 label.text = Date().fullDateString(.yearMonthDay)

 label.text = "2023:12:25".format(.yearMonthDay)

 String으로 내려온다면 fullStringDate() 메서드 내에서 내려오는 값에 맞게
 return를 작성해야 한다.

 FormatType에는 바꾸고 싶은 형태로 설정해주면 된다.

 */

import Foundation

struct Formatter {
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()

    private init() {}
}

public extension Date {
    enum FormatType: String {
        case yearMonthDay = "YYYY/MM/dd"
        case hourMinute = "HH:mm"

        var displayName: String {
            return self.rawValue
        }
    }

    func fullDateString(_ type: FormatType) -> String {
        Formatter.shared.dateFormat = type.displayName
        guard let dateString = Formatter.shared.string(for: self) else { return "" }
        return dateString
    }
}

public extension String {
    enum FormatType: String {
        case yearMonthDay = "YYYY/MM/dd"
        case hourMinute = "HH:mm"

        var displayName: String {
            return self.rawValue
        }
    }

    func format(_ type: FormatType) -> String {
        let dateData = fullStringDate(type)
        Formatter.shared.dateFormat = type.displayName
        let dateString = Formatter.shared.string(from: dateData)
        return dateString
    }

    func fullStringDate(_ type: FormatType = .yearMonthDay) -> Date {
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
