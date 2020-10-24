import Foundation



public func timeAgoSince(_ date: Date) -> String {
    
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    
    if let year = components.year, year >= 2 {
        return "\(year) 년 전"
    }
    
    if let year = components.year, year >= 1 {
        return "작년"
    }
    
    if let month = components.month, month >= 2 {
        return "\(month) 개월 전"
    }
    
    if let month = components.month, month >= 1 {
        return "지난 달"
    }
    
    if let week = components.weekOfYear, week >= 2 {
        return "\(week) 주 전"
    }
    
    if let week = components.weekOfYear, week >= 1 {
        return "지난 주"
    }
    
    if let day = components.day, day >= 2 {
        return "\(day) 일 전"
    }
    
    if let day = components.day, day >= 1 {
        return "어제"
    }
    
    if let hour = components.hour, hour >= 2 {
        return "\(hour) 시간 전"
    }
    
    if let hour = components.hour, hour >= 1 {
        return "한 시간 전"
    }
    
    if let minute = components.minute, minute >= 2 {
        return "\(minute) 분 전"
    }
    
    if let minute = components.minute, minute >= 1 {
        return "방금"
    }
    
    if let second = components.second, second >= 3 {
        return "\(second) 방금"
    }
    
    return "방금"
    
}
