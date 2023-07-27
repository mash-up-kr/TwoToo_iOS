//
//  Date+.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public extension Date {
    func dateToString(_ type: DateFormatType) -> String {
        Formatter.shared.dateFormat = type.displayName
        guard let dateString = Formatter.shared.string(for: self) else { return "" }
        return dateString
    }
}
