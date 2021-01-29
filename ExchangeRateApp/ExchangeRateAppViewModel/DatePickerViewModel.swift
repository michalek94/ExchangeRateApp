//
//  DatePickerViewModel.swift
//  ExchangeRateAppViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class DatePickerViewModel {

    public var actionTitle: String { return "Select" }

    public var date: Date?
    public var minimumDate: Date?
    public var maximumDate: Date?
    public var completion: ((Date?) -> Void)

    public init(date: Date? = nil,
                minimumDate: Date? = nil,
                maximumDate: Date? = nil,
                completion: @escaping ((Date?) -> Void)) {
        self.date = date
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.completion = completion
    }

    public func dateSelected(_ selectedDate: Date) { completion(selectedDate) }

    public func dismiss() { completion(nil) }

}
