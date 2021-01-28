//
//  UIColor+Extensions.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 28/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

extension UIColor {
    @nonobjc class var white: UIColor { UIColor(white: 1.0, alpha: 1.0) }
    @nonobjc class var whiteDisabled: UIColor { UIColor(white: 1.0, alpha: 0.5) }
    @nonobjc class var blueEnabled: UIColor { UIColor(red: 84.0 / 255.0, green: 150.0 / 255.0, blue: 192.0 / 255.0, alpha: 1.0) }
    @nonobjc class var blueDisabled: UIColor { UIColor(red: 84.0 / 255.0, green: 150.0 / 255.0, blue: 192.0 / 255.0, alpha: 0.3) }
    @nonobjc class var offWhite: UIColor { UIColor(red: 244.0 / 255.0, green: 243.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0) }
    @nonobjc class var gray: UIColor { UIColor(red: 170.0 / 255.0, green: 167.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0) }
    @nonobjc class var black: UIColor { UIColor(white: 0.0, alpha: 1.0) }
    @nonobjc class var blackDisabled: UIColor { UIColor(white: 0.0, alpha: 0.5) }
}
