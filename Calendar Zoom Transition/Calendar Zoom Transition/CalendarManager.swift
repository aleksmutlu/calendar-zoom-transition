//
//  CalendarManager.swift
//  Calendar Zoom Transition
//
//  Created by Aleks Mutlu on 7.12.2021.
//

import Foundation
import UIKit

struct Month {
    let index: Int
    let title: String
    let startDayIndex: Int
    let numberOfDays: Int
    let dayIndexTable: [Int: Int]
    
    init(index: Int, title: String, startDayIndex: Int, numberOfDays: Int) {
        self.index = index
        self.title = title
        self.startDayIndex = startDayIndex
        self.numberOfDays = numberOfDays
        
        for i in (1...numberOfDays) {
            index 
        }
    }
}

// TODO: Code style
final class CalendarManager {
    
    // MARK: - Properties
    
    private(set) var months: [Month] = []
    
    // MARK: -
    
    init() {
        prepareMonths()
    }
    
    // MARK: - Private
    
    private func prepareMonths() {
        let formatter = DateFormatter()
        formatter.locale = .current
        
        guard let currentYear = Calendar.current.dateComponents([.year], from: Date()).year else {
            fatalError("Unable to get current year")
        }
        
        var dates: [Date] = []
        
        for i in (1...12) {
            var components = DateComponents()
            components.year = currentYear
            components.month = i
            components.day = 1
            guard let date = Calendar.current.date(from: components) else {
                fatalError("Couldn't create date")
            }
            dates.append(date)
        }
        
        for (i, shortMonthTitle) in formatter.shortMonthSymbols.enumerated() {
            let date = dates[i]
            
            let startDayIndex = getStartDayIndexOfMonth(from: date)
            let numberOfDays = getNumberOfDays(of: date)
            
            let month = Month(index: i, title: shortMonthTitle, startDayIndex: startDayIndex, numberOfDays: numberOfDays)
            months.append(month)
        }
    }
    
    private func getStartDayIndexOfMonth(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekday], from: date).weekday!
    }
    
    private func getNumberOfDays(of date: Date) -> Int {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)!
        let oneDayBeforeNextMonth = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)!
        return Calendar.current.dateComponents([.day], from: oneDayBeforeNextMonth).day!
    }
    
    // MARK: - Public
    
    func getMonth(at index: Int) -> Month {
        return months[index]
    }
}
