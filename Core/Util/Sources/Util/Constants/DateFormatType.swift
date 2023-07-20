//
//  DateFormatType.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public enum DateFormatType: String {
    case yearMonthDay = "YYYY/MM/dd"
    case hourMinute = "HH:mm"

    var displayName: String {
        return self.rawValue
    }
}
