//
//  SegmentedControl.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 28/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon

public class SegmentedControl: UISegmentedControl {

    private var normalStateAttributes: [NSAttributedString.Key: AnyObject] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 0.0
        return [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.blackDisabled,
            NSAttributedString.Key.backgroundColor: UIColor.clear
        ]
    }()

    private var selectedStateAttributes: [NSAttributedString.Key: AnyObject] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 0.0
        return [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.backgroundColor: UIColor.clear
        ]
    }()

    public init() {
        super.init(frame: .zero)

        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 4.0
        layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.borderWidth = 1.0
        tintColor = .offWhite
        setTitleTextAttributes(normalStateAttributes, for: .normal)
        setTitleTextAttributes(selectedStateAttributes, for: .selected)
    }

    required public init?(coder aDecoder: NSCoder) { nil }

    public func insertSegments(_ segments: [String]) {
        for (index, segmentTitle) in segments.enumerated() {
            insertSegment(withTitle: segmentTitle, at: index, animated: false)
        }
        selectedSegmentIndex = 0
    }

}
