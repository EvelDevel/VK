
//  Created by Евгений Никитин on 07.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import Foundation

class DateTimeHelper {
    
    /// Просто форматированная дата
    public static func getDateTimeString(dateTime : Date?, format : String) -> String {
        let dateTime = dateTime ?? Date();
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateTime)
    }
    
    /// Хитро-форматированная дата
    public static func getFormattedDate(from dateTime: Date) -> String {
        let timeFormat = DateFormatter()
        let dateFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        dateFormat.dateStyle = .full
        dateFormat.locale = Locale.init(identifier: "ru_RU")
        dateFormat.dateFormat = "dd MMM"
        
        if Calendar.current.isDateInToday(dateTime) {
            return "сегодня в \(timeFormat.string(from: dateTime))"
        } else if Calendar.current.isDateInYesterday(dateTime) {
            return "вчера в \(timeFormat.string(from: dateTime))"
        } else {
            return "\(dateFormat.string(from: dateTime)) в \(timeFormat.string(from: dateTime))"
        }
    }
}
