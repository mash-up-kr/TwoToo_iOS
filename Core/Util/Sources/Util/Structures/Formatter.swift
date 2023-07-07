//
//  Formatter.swift
//  
//
//  Created by Eddy on 2023/06/08.
//


/*

 String으로 내려온다면 fullStringDate() 메서드 내에서 내려오는 값에 맞게
 return를 작성해야 한다.

 서버에서 2023-10-03 13:12:11로 내려온다면 fullStringDate()의 formatString의 return 값으로 그와 동일한 형식으로 반환값을 넣어주어야 한다.
 String -> Date -> String 형식으로 바꾸어야 원하는 형식으로 바꿀 수 있다.

 Date 타입인 경우에는 String으로 바꾸며 원하는 타입으로 바꾸게 만든다.
 FormatType에 원하는 형식을 작성하여 사용하면 된다.

 label.text = Date().fullDateString(.yearMonthDay)

 label.text = "2023:12:25".format(.yearMonthDay) // 2023/12/25
 label.text = "2023:12:25 11:30".format(.hourMinute) // 11:30

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
