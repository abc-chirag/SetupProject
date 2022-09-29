//
//  Date+Extension.swift
//  Trichordal
//
//  Created by Kartum Infotech on 15/02/19.
//  Copyright © 2019 Kartum Infotech. All rights reserved.
//

import Foundation

extension Date {
    public func getDateStringWithFormate(_ formate: String, timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone(abbreviation: timezone)
        return formatter.string(from: self)
    }
    
    public func getCurrentTime(_ dateToConvert: Date = Date()) -> String {
        let objDateformat: DateFormatter = DateFormatter()
//        objDateformat.locale = Locale(identifier: "en_US_POSIX")
//        objDateformat.timeZone = TimeZone(abbreviation: "IST")
        objDateformat.dateFormat = "H:m:s"//"h:mm:ss"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        return strTime
    }
    
    public func getTimeFormate(_ time: String) -> String {
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = "HH:mm:ss"
        
        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = "h:mm a"
        
        let inStr = time
        let date = inFormatter.date(from: inStr)!
        let outStr = outFormatter.string(from: date)
        return outStr
    }
    
    public func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    public func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    public func getFeatureAndPastTime24Hour(_ pastNdFeatureHour: Int)  -> String {
        let featureDate = Calendar.current.date(
            byAdding: .hour,
            value: pastNdFeatureHour,
            to: Date()) ?? Date()
        
        let inFormatter = DateFormatter()
        inFormatter.dateFormat = "HH"
        let timeString = inFormatter.string(from: featureDate)
        return timeString
    }
    
    public func getFeatureAndPastTime12Hour(_ pastNdFeatureHour: String)  -> String {
        let inFormatter = DateFormatter()
        //inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = "HH"
        
        let outFormatter = DateFormatter()
        //  outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = "hh:mm a"
        
        let inStr = pastNdFeatureHour
        let date = inFormatter.date(from: inStr)!
        let outStr = outFormatter.string(from: date)
        return outStr
    }
    
    public func getFeatureAndPastTime12HourHalfHour(_ pastNdFeatureHour: String)  -> String {
        let inFormatter = DateFormatter()
        //inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = "HH:mm"
        
        let outFormatter = DateFormatter()
        //  outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = "hh:mm a"
        
        let inStr = pastNdFeatureHour
        let date = inFormatter.date(from: inStr)!
        let outStr = outFormatter.string(from: date)
        return outStr
    }
    
    public func get12HourTo24Hour(_ pastNdFeatureHour: String)  -> String {
        let inFormatter = DateFormatter()
        //inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = "hh:mm a"
        
        let outFormatter = DateFormatter()
        //  outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = "HH"
        
        let inStr = pastNdFeatureHour
        let date = inFormatter.date(from: inStr)!
        let outStr = outFormatter.string(from: date)
        return outStr
    }
    
    public func getFeatureDate(_ pastNdFeatureDate: Int = 7)  -> Date {
        let weekDate = Calendar.current.date(byAdding: .weekday, value: pastNdFeatureDate, to: Date()) ?? Date()
        return weekDate
    }
    
    public func getParticularDateDay(_ selectedDate: Date)  -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ccc"
        return dateFormatter.string(from: selectedDate)
    }
    
    public func getAgeFromDOF(date: String) -> (Int,Int,Int) {

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateOfBirth = dateFormater.date(from: date)

        let calender = Calendar.current

        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())

        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
}

extension Date {
    func formattedTimeAgo() -> String {
        let currentDate = Date()
        let numericDates = true
        
        let calendar = Calendar.current
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: self, to: currentDate, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) Year Ago"
        } else if (components.year! >= 1) {
            if (numericDates) {
                return "1 Year Ago"
            } else {
                return "Last Year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) Months Ago"
        } else if (components.month! >= 1) {
            if (numericDates) {
                return "1 Months Ago"
            } else {
                return "Last Months"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) Weeks Ago"
        } else if (components.weekOfYear! >= 1) {
            if (numericDates) {
                return "1 Week Ago"
            } else {
                return "Last Week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) Days Ago"
        } else if (components.day! >= 1) {
            if (numericDates) {
                return "1 Day Ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) Hours ago"
        } else if (components.hour! >= 1) {
            if (numericDates) {
                return "1 Hour Ago"
            } else {
                return "An Hour Ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) Minuites Ago"
        } else if (components.minute! >= 1) {
            if (numericDates) {
                return "1 Minuite Ago"
            } else {
                return "A Minuite Ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) Seconds Ago"
        } else {
            return "Just now"
        }
    }
}


extension Date {
    func isBetween(_ date1: Date, _ date2: Date) -> Bool {
        return date1 < date2
            ? DateInterval(start: date1, end: date2).contains(self)
            : DateInterval(start: date2, end: date1).contains(self)
    }
}
