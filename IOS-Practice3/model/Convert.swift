//
//  Convert.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/11.
//

import UIKit

class Convert: NSObject {
    static let shared = Convert()
    func convertDuration(duration: Int) -> String{
        var second = String(duration % 60)
        var minute = String((duration / 60 ) % 60)
        let hour = String(duration / 3600)
        if (second.count == 1){
            second = "0" + second
        }
        if (minute.count == 1){
            minute = "0" + minute
        }
        if (hour == "0"){
            return "\(minute):\(second)"
        }
        return "\(hour):\(minute):\(hour)"
    }
    func convertTime(time: String) -> String {
        let date = stringToDate(dateString: time)
        let currentDate = Date()
        let diffComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day], from:date, to: currentDate)
        if (diffComponents.day != 0){
            return "• \(diffComponents.day ?? 0)일 전"
        }
        else if (diffComponents.hour != 0){
            return "• \(diffComponents.hour ?? 0)시간 전"
        }
        else if (diffComponents.minute != 0){
            return "• \(diffComponents.minute ?? 0)분 전"
    }
        else {
            return "• \(diffComponents.second ?? 0)초 전"
        }
    }
    //데이터 가져와서 분전 초전 일전 개월전으로 나누기
    func stringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date: Date = dateFormatter.date(from: dateString) ?? Date()
        return date
    }
    
    func convertCount(count:Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: count)) ??  ""
        return result
    }
//    func convertCC(display: String) -> String{
//        return "\(display)야미다 씨발년아"
//    }
//
}




