//
//  FoundationExtensions.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation

// MARK: - Date - Comparing self with now

public extension Date {
    
    var startOfTheDay: Date {
        return Calendar.autoupdatingCurrent.startOfDay(for: self)
    }
    
    var startOfTheHour: Date {
        let seconds = Calendar.autoupdatingCurrent.component(.hour, from: self) * 3600
        return Calendar.autoupdatingCurrent.startOfDay(for: self) + TimeInterval(seconds)
    }
    
    var startOfTheMinute: Date {
        let seconds = TimeInterval(Calendar.autoupdatingCurrent.component(.second, from: self))
        let nanoSeconds = timeIntervalSince1970 - TimeInterval(Int(timeIntervalSince1970))
        return self - seconds - nanoSeconds
    }
    
    var isSameHourAsNow: Bool {
        guard Calendar.autoupdatingCurrent.isDateInToday(self) else { return false }
        let selfHour = Calendar.autoupdatingCurrent.component(.hour, from: self)
        let nowHour = Calendar.autoupdatingCurrent.component(.hour, from: Date())
        return selfHour == nowHour
    }
    
    var shortStyle: String {
        return DateFormatter.localizedString(from: self, dateStyle: .short, timeStyle: .short)
    }
}

@available(iOS 10.0, *)
public extension ISO8601DateFormatter {
    
    convenience init(timeZone: TimeZone) {
        self.init()
        self.timeZone = timeZone
    }
}

public extension DateFormatter {
    
    convenience init(dateFormat: String?, timeZone: TimeZone?) {
        self.init()
        self.dateFormat = dateFormat
        self.timeZone = timeZone
    }
}

// MARK: - The hours in today in self; the timezone of an iso8601 or rfc 822 date string

public extension TimeZone {
    
    var hourOfTheDay: Int {
        var calendar = Calendar.autoupdatingCurrent
        calendar.timeZone = self
        return calendar.component(.hour, from: Date())
    }
    
    var hoursRemainingInToday: Int {
        return 23 - hourOfTheDay
    }
    
    static func timeZoneFor(iso8601OrRFC822TimeZone dateString: String) -> TimeZone? {
        let iso8601OrRFC822TimeZonePattern = "([+-])(0\\d|1[0-4]):?([0-5]\\d)$"
        let regex = try! NSRegularExpression(pattern: iso8601OrRFC822TimeZonePattern, options: .anchorsMatchLines)
        guard let match = regex.firstMatch(in: dateString, options: [], range: NSRange(location: 0, length: dateString.utf16.count)),
            match.numberOfRanges == 4 else { return nil }
        
        let substrings = match.substrings(of: dateString)
        guard let sign = Int(substrings[1] + "1"), let hours = Int(substrings[2]), let minutes = Int(substrings[3]) else { return nil }
        let offset = (hours * 3600 + minutes * 60) * sign
        return TimeZone(secondsFromGMT: offset)
    }
    
    static func hoursRemainingInDay(of dateString: String) -> Int? {
        guard let timeZone = timeZoneFor(iso8601OrRFC822TimeZone: dateString) else { return nil }
        return timeZone.hoursRemainingInToday
    }
    
    static func hourOfTheDay(of dateString: String) -> Int? {
        guard let timeZone = timeZoneFor(iso8601OrRFC822TimeZone: dateString) else { return nil }
        return timeZone.hourOfTheDay
    }
}

// MARK: - OperationQueue - Completion operation for a list of operations

public extension OperationQueue {
    
    convenience init(qualityOfService: QualityOfService) {
        self.init()
        self.qualityOfService = qualityOfService
    }
    
    func addOperations(operations: [Operation], completionOperation: Operation) {
        operations.forEach {
            completionOperation.addDependency($0)
            addOperation($0)
        }
        addOperation(completionOperation)
    }
    
    func add(_ block: @escaping () ->()) {
        addOperation(block)
    }
}


// MARK: - Shortened NSLocalizedString

func NSLocalizedString(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

public extension Array {
    
    var dropFirst: Array {
        return Array(dropFirst())
    }
}

var mainQueue: OperationQueue { return OperationQueue.main }

