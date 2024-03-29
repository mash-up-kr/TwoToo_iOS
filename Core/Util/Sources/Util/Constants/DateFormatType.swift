//
//  DateFormatType.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public enum DateFormatType: String {
    case shortYearMonthDay = "yy/MM/dd"
    case yearMonthDay = "YYYY/MM/dd"
    case monthDay = "MM/dd"
    case hourMinute = "HH:mm"
    case iso = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    case hangleYearMonthDay = "yyyy년 MM월 dd일"
    case monthDayE = "M월 d일 (E)"


    var displayName: String {
        return self.rawValue
    }
}
