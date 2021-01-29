//
//  AppDateFormatter.swift
//  ExchangeRateAppCommon
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class AppDateFormatter {
    
    public static let shared = AppDateFormatter()
    
    private let dateFormatter = DateFormatter()
    
    public init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    public func date(from text: String,
                     withFormat format: String = "yyyy-MM-dd") -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: text)
    }
    
    public func string(from date: Date,
                       withFormat format: String = "yyyy-MM-dd") -> String? {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}
