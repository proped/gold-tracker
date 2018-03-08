//
//  NSDateExtension.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation


extension Date {
    
    // is self <= date
    func isLessOrEqualThen(_ compareDate:Date) -> Bool {
        
        let calendar            = Calendar.current
        let components          = (calendar as NSCalendar).components([.day , .month , .year], from: self)
        let compareComponents   = (calendar as NSCalendar).components([.day , .month , .year], from: compareDate)
        
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        if year < compareYear {
            return true
        }
        else if (year == compareYear) && (month < compareMonth) {
            return true
        }
        else if (month == compareMonth) && (day <= compareDay) {
            return true
        }
        
        return false
        
    }
    
    // is self >= date
    func isMoreOrEqualThen(_ compareDate:Date) -> Bool {
        
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.day, .month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.day, .month, .year], from: compareDate)
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)

        
        if year > compareYear {
            return true
        }
        else if (year == compareYear) {
            if (month > compareMonth) {
                return true
            }
            else if (month == compareMonth) {
                if (day >= compareDay) {
                    return true
                }
            }
        }        
        
        return false
        
    }
    
    func isSameDate(_ compareDate: Date) -> Bool {
        
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.day, .month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.day, .month, .year], from: compareDate)
        let day             = Int(components.day!)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareDay     = Int(compareComponents.day!)
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        return  (year == compareYear) && (month == compareMonth) && (day == compareDay)
    }
    
    func isSameMonth(_ compareDate: Date) -> Bool {
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.month, .year], from: self)
        let compareComponents   = calendar.dateComponents([.month, .year], from: compareDate)
        let month           = Int(components.month!)
        let year            = Int(components.year!)
        
        let compareMonth   = Int(compareComponents.month!)
        let compareYear    = Int(compareComponents.year!)
        
        return  (year == compareYear) && (month == compareMonth)
    }
    
    func isSameYear(_ compareDate: Date) -> Bool {
        let calendar            = Calendar.current
        let components          = calendar.dateComponents([.year], from: self)
        let compareComponents   = calendar.dateComponents([.year], from: compareDate)
        let year            = Int(components.year!)
        let compareYear    = Int(compareComponents.year!)
        return  (year == compareYear)
    }
    
    
    func isToday() -> Bool {
        return self.isSameDate(Date())
    }
    
    func isFalls(between startDate: Date, endDate: Date) -> Bool {
        return (startDate...endDate).contains(self)
    }
   

    func numberOfDaysUntilDateTime(_ toDateTime: Date) -> Int {
        return Date.numberOfDaysBetween(self, end: toDateTime)
    }
    
    static func dateFrom(_ year : Int , month : Int , day : Int) -> Date? {
        
        let calendar        = Calendar.current
        var components      = DateComponents()
        components.day      = day
        components.month    = month
        components.year     = year
        components.hour     = 0
        components.minute   = 0
        components.second   = 0
        
        return calendar.date(from: components)
    }
  
    
    func toDateString(_ strDateFormat : String) -> String {
        // parser to date string
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = strDateFormat
        
        // format 20XX-XX-XX
        dateFormatter.calendar      = Calendar(identifier: Calendar.Identifier.gregorian) // use fix calendar
        
        return dateFormatter.string(from: self)
    }
    
    func toDateString(_ strDateFormat : String, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormat
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian) // use fix calendar
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
    
    func getTomorrowDate() -> Date? {
        //let today = NSDate()
        let tomorrow = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: 1,
            to: self, //today ,
            options: NSCalendar.Options(rawValue: 0))
        
        return tomorrow
        
    }

    func getYesterdayDate() -> Date? {
        let tomorrow = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: -1,
            to: self, //today ,
            options: NSCalendar.Options(rawValue: 0))
        
        return tomorrow
    }
    
    func goBack(months: Int) -> Date {
        let lastMonth = (Calendar.current as NSCalendar).date(byAdding: .month, value: -1*months, to: self, options: NSCalendar.Options(rawValue: 0))
        return lastMonth!
    }
    
    func goNext(months: Int) -> Date {
        let nextMonth = (Calendar.current as NSCalendar).date(byAdding: .month, value: 1*months, to: self, options: NSCalendar.Options(rawValue: 0))
        return nextMonth!
    }
    
    func getPreviosMonth() -> Date {
        let lastMonth = (Calendar.current as NSCalendar).date(byAdding: .month, value: -1, to: self, options: NSCalendar.Options(rawValue: 0))
        return lastMonth!
    }
    
    func getNextMonth() -> Date {
        let nextMonth = (Calendar.current as NSCalendar).date(byAdding: .month, value: 1, to: self, options: NSCalendar.Options(rawValue: 0))
        return nextMonth!
    }
    
    func getPreviosYear() -> Date {
        let lastYear = (Calendar.current as NSCalendar).date(byAdding: .year, value: -1, to: self, options: NSCalendar.Options(rawValue: 0))
        return lastYear!
    }
    
    func getNextYear() -> Date {
        let nextYear = (Calendar.current as NSCalendar).date(byAdding: .year, value: 1, to: self, options: NSCalendar.Options(rawValue: 0))
        return nextYear!
    }
    
    func getDateAfter(_ numberOfDay : Int) -> Date? {
        //let today = NSDate()
        let dayAfter = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: numberOfDay,
            to: self, //today ,
            options: NSCalendar.Options(rawValue: 0))
        
        return dayAfter
        
    }
    
    static func numberOfDaysBetween(_ start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let flags = NSCalendar.Unit.day
        let components = (calendar as NSCalendar).components(flags, from: date1, to: date2, options: [])
        
        return components.day!
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func dateNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return Int(components.day!)
    }
    
    func monthNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return Int(components.month!)
    }
    
    func yearNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return Int(components.year!)
    }
    
    func daysInMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        return  range.count
    }
    
    func getDateInSameMonth(number: Int) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.day = number
        return calendar.date(from: components)
    }
    
    func isWeekEnd() -> Bool {
        let weekday = Calendar.current.component(.weekday, from: self)
        
        return (weekday == 7) || (weekday == 1) // sat or sun
    }
    
    func startOfWeek() -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        return calendar.date(from: dateComponents)!
    }
    
    func endOfWeek() -> Date {
        let calendar = Calendar.current
        let startOf = self.startOfWeek()
        var dummyComponents = DateComponents()
        dummyComponents.day = 6
        let endOfWeek = calendar.date(byAdding: dummyComponents, to: startOf)!
        return endOfWeek
    }
    
    func startOf(component: Calendar.Component) -> Date {
        
        let selectComponents = Date.getDateComponents(component: component)
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(selectComponents, from: self)
        return calendar.date(from: dateComponents)!
    }
    
    func endOf(component: Calendar.Component) -> Date {
        
        let calendar = Calendar.current
        let startOf = self.startOf(component: component)
        
        var dummyComponents = DateComponents()
        
        switch component {
        case .year:
            dummyComponents.day = -1
            dummyComponents.year = 1
        case .month:
            dummyComponents.day = -1
            dummyComponents.month = 1
        case .day:
            dummyComponents.hour = -1
            dummyComponents.day = 1
        default:
            dummyComponents.day = -1
        }
        
        let endOf = calendar.date(byAdding: dummyComponents, to: startOf)!
        
        return endOf
    }
    
    func lastMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = -1
        let date = calendar.date(byAdding: components, to: self)!
        return date.startOf(component: .month)
    }
    
    func nextMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        let date = calendar.date(byAdding: components, to: self)!
        return date.startOf(component: .month)
    }

    
    private static func getDateComponents(component: Calendar.Component) -> Set<Calendar.Component> {
        let components = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]
        
        var selectComponents: Set<Calendar.Component> = []
        
        for cursorComponent in components {
            selectComponents.insert(cursorComponent)
            if cursorComponent == component { break }
        }
        
        return selectComponents
    }
}
