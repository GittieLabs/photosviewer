//
//  Utils.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/11/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import Foundation

extension NSDate {
    private var calendar: NSCalendar{
        get {
            return NSCalendar.currentCalendar()
        }
    }
    // computed property to return the day of the month
    var day: Int   {
        get{
            return calendar.component(.Day, fromDate: self)
        }
    }
    // computed property to return the month of the year
    var month: Int {
        get{
            return calendar.component(.Month, fromDate: self)
        }
    }
    // computed proerty to return the year
    var year: Int  {
        get{
            return calendar.component(.Year, fromDate: self)
        }
    }
    
    func dateByAddingYears(years: Int)->NSDate{
        return calendar.dateByAddingUnit(.Year, value: years, toDate: self, options: [])!
    }
    
    func dateByAddingMonths(months: Int)->NSDate{
        return calendar.dateByAddingUnit(.Month, value: months, toDate: self, options: [])!
    }
    
    func dateByAddingDays(days: Int)->NSDate{
        return calendar.dateByAddingUnit(.Day, value: days, toDate: self, options: [])!
    }
}
