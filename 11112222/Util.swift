//
//  Util.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 21..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class Util {
    
    static func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date // 현재
        let latest = (earliest == now) ? date : now // 더 옛날
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    static func timeLeftFromNow(_ date:Date) -> (Bool,String) {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .second]
        let now = Date()
        
        guard now <= date else {
            return (false,"투표마감")
        }
        
        let earliest = now
        let latest = date
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if components.day! >= 2 {
            return (true, "\(components.day!) days left")
        } else if components.day! >= 1{
            return (true, "1 day left")
        } else if components.hour! >= 2 {
            return (true, "\(components.hour!) days left")
        } else if components.hour! >= 1 {
            return (true, "1 hour left")
        } else if components.minute! >= 2 {
            return (true, "\(components.minute!) minutes left")
        } else if components.minute! >= 1 {
            return (true,"1 minute left")
        } else {
            return (true, "\(components.second!) seconds left")
        }
    }
    
    static func getCurrentTimeStamp()->Double{
        return Date().timeIntervalSince1970 * 1000
    }
    
}

extension Date {
    
    static func getDateFromString(_ dateString: String) -> Date {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy.MM.dd"
        dateStringFormatter.locale = Locale(identifier: "ko_KR")
        let date = dateStringFormatter.date(from: dateString) ?? Date()
        print("date \(date)")
        return Date(timeInterval: 0, since: date)
    }
    
    static func localTime(date: Date) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        //        let hour = calendar.component(.hour, from: date)
        //        let minutes = calendar.component(.minute, from: date)
        return "\(year).\(month).\(day)"
    }
    
    
    func convertFIRTimeStampToDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let dateStr = dateFormatter.string(from: date)
        
        return dateStr
    }
    
    static func convertDateToTimeStamp(_ future: Date) -> Double {
        
        let date = Date()
        let futureTimeInterval = date.timeIntervalSince1970 - date.timeIntervalSince(future)
        
        return futureTimeInterval * 1000
    }
    
}

extension UIFont {
    var isBold: Bool
    {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    func setBoldFnc() -> UIFont
    {
        if(isBold)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func detBoldFnc() -> UIFont
    {
        if(!isBold)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func toggleBoldFnc()-> UIFont
    {
        if(isBold)
        {
            return detBoldFnc()
        }
        else
        {
            return setBoldFnc()
        }
    }
}



