//
//  PaddableTextField.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

public class PaddableTextField: UITextField {

    private let padding: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)

    public init() {
        super.init(frame: .zero)
        styleViews()
    }

    required init?(coder aDecoder: NSCoder) { nil }

    private func styleViews() {
        backgroundColor = .white
    }

    private func calculateRectWithPadding(forBounds bounds: CGRect) -> CGRect {
        let paddedRect = bounds.inset(by: padding)
        if leftViewMode == .always || leftViewMode == .unlessEditing {
            return adjustRectWithWidthView(bounds: paddedRect)
        }
        if rightViewMode == .always || rightViewMode == .unlessEditing {
            return adjustRectWithWidthView(bounds: paddedRect)
        }
        return paddedRect
    }

    private func adjustRectWithWidthView(bounds: CGRect) -> CGRect {
        var paddedRect = bounds
        if let leftView = leftView {
            paddedRect.origin.x += leftView.frame.width
            paddedRect.size.width -= leftView.frame.width
        }
        if let rightView = rightView {
            paddedRect.size.width -= rightView.frame.width
        }
        return paddedRect
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return calculateRectWithPadding(forBounds: bounds)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return calculateRectWithPadding(forBounds: bounds)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return calculateRectWithPadding(forBounds: bounds)
    }

}
