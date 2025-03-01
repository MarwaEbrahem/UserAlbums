//
//  File.swift
//  
//
//  Created by 2B on 28/08/2024.
//

import Foundation
import UIKit

public class Utilities {
    
    public static let shared = Utilities()
    
    private init() {}
    
    public func handelGettingTime(_ timeString: String, inputFormat: String = "HH:mm:ss") -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent behavior
        timeFormatter.dateFormat = inputFormat
        
        // Truncate fractional seconds if present
        let truncatedTimeString = timeString.split(separator: ".").first ?? ""
        
        if let date = timeFormatter.date(from: String(truncatedTimeString)) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "en_US_POSIX") // Fixed locale for output
            outputFormatter.dateFormat = "hh:mm a"
            
            if UserDefaults.standard.string(forKey: "UKPrefLang") == "ar" {
                outputFormatter.amSymbol = "ص" // Arabic AM symbol
                outputFormatter.pmSymbol = "م" // Arabic PM symbol
            } else {
                outputFormatter.amSymbol = "am"
                outputFormatter.pmSymbol = "pm"
            }
            
            let formattedTime = outputFormatter.string(from: date)
            print("Formatted Time: \(formattedTime)")
            return formattedTime
        } else {
            print("Invalid time string format")
            return "--:--"
        }
    }
    public func convertToHoursAndMinutes(from timeString: String) -> String {
        let timeComponents = timeString.split(separator: ":")
        if timeComponents.count >= 2,
           let hours = Int(timeComponents[0]),
           let minutes = Int(timeComponents[1]),
           let secondsComponent = timeComponents[2].split(separator: ".").first,
           let seconds = Int(secondsComponent) {
            let totalMinutes = hours * 60 + minutes + (seconds >= 30 ? 1 : 0)
            
            let finalHours = totalMinutes / 60
            let finalMinutes = totalMinutes % 60
            
            return String(format: "%02d:%02d", finalHours, finalMinutes)
        }
        return "--:--"
    }

}

extension Utilities {
    
    public func getFirstDayDateInCurrentMonthFormatted() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        if let firstDayOfMonth = calendar.date(from: components) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.string(from: firstDayOfMonth)
        }
        
        return ""
    }
    
    public func getTodayDateFormatted() -> String {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: currentDate)
    }
    
    public func getStringDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        print("Selected date: \(formattedDate)")
        return formattedDate
    }
    
    public func convertToDateFormatte(_ inputDateString: String, outputFormat: String = "dd MMM, yyyy") -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        var date: Date? = inputFormatter.date(from: inputDateString)
        
        if date == nil {
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            date = inputFormatter.date(from: inputDateString)
        }
        
        if let validDate = date {
            let outputFormatter = DateFormatter()
            
            if UserDefaults.standard.string(forKey: "UKPrefLang")! == "ar" && outputFormat != "yyyy-MM-dd" {
                outputFormatter.locale = Locale(identifier: "ar")
            }else {
                outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            }
            
            outputFormatter.dateFormat = outputFormat
            let outputDateString = outputFormatter.string(from: validDate)
            return outputDateString
        } else {
            print("Invalid date format")
            return ""
        }
    }

    
    public func convertToMonthFormatte(_ inputDateString: String) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        inputFormatter.dateFormat = "M-yyyy"
        var date: Date? = inputFormatter.date(from: inputDateString)
        
        if date == nil {
            inputFormatter.dateFormat = "MM-yyyy"
            date = inputFormatter.date(from: inputDateString)
        }
        
        if let validDate = date {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM, yyyy"
            
            if UserDefaults.standard.string(forKey: "UKPrefLang")! == "ar" {
                outputFormatter.locale = Locale(identifier: "ar")
            } else {
                outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            }
            
            let outputDateString = outputFormatter.string(from: validDate)
            return outputDateString
        } else {
            print("Invalid date format")
            return ""
        }
    }
    
    public func daysBetween(_ start: String, _ end: String) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let startDate = dateFormatter.date(from: start),
           let endDate = dateFormatter.date(from: end) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: startDate, to: endDate)
            return (components.day ?? 0) + 1
        }
        
        return 0
    }
    
    public func checkIsFutureDate(_ inputDateString: String, outputFormat: String = "dd MMM, yyyy") -> Bool {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        var date: Date? = inputFormatter.date(from: inputDateString)
        if date == nil {
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            date = inputFormatter.date(from: inputDateString)
        }
    
        if let validDate = date {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            outputFormatter.dateFormat = outputFormat
            let calendar = Calendar.current
            if calendar.isDateInToday(validDate) {
                return false
            }
    
            else if validDate > Date() {
                return true
            } else {
                return false
            }
            
        } else {
            print("Invalid date format")
            return false
        }
    }


    public func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString) // Convert String to Date
    }
    
    public func stringToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
            
            // Ensure the formatter matches the input string format exactly
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0) // Force UTC timezone for consistency
            
            return formatter.date(from: dateString)
    }
    
    public func numberOfDaysBetween(_ startDate: String, _ endDate: String) -> Int? {
        // Convert the start and end date strings to Date objects            
            guard let start = stringToDate(startDate),
                  let end = stringToDate(endDate) else {
                print("Date conversion failed.")
                return nil // Return nil if date parsing fails
            }
            
            // Normalize the times to avoid time zone differences
            let calendar = Calendar.current
            let normalizedStart = calendar.startOfDay(for: start) // Strip time components
            let normalizedEnd = calendar.startOfDay(for: end)
            
            // Calculate the number of days between the two normalized dates
            let components = calendar.dateComponents([.day], from: normalizedStart, to: normalizedEnd)
            
            return components.day
    }
    
    public func monthAbbreviation(from monthNumber: Int, dateFormat: String = "MMM") -> String? {
        
        let dateFormatter = DateFormatter()
        
        if UserDefaults.standard.string(forKey: "UKPrefLang")! == "ar" {
            dateFormatter.locale = Locale(identifier: "ar")
        } else {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        }
        
        let calendar = Calendar.current

        let components = DateComponents(calendar: calendar, year: 2000, month: monthNumber, day: 1)
        
        if let date = calendar.date(from: components) {
            dateFormatter.dateFormat = dateFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }

}

extension Utilities {
    public func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
}
