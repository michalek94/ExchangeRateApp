//
//  DropDownTextField.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon

public protocol DropDownTextFieldDelegate: class {
    func onDropDownTapped(inView view: DropDownTextField)
}

public class DropDownTextField: BaseView {

    public weak var delegate: DropDownTextFieldDelegate?

    public var text: String? {
        set {
            textField.text = newValue
        }
        get {
            return textField.text
        }
    }
    
    public var placeholder: String? {
        set {
            textField.attributedPlaceholder = NSAttributedString(string: newValue ?? "",
                                                                 attributes: [.foregroundColor: UIColor.lightGray,
                                                                              .font: UIFont.systemFont(ofSize: 18.0, weight: .light)])
        }
        get {
            return textField.attributedPlaceholder?.string
        }
    }

    private lazy var textField: UITextField = { PaddableTextField() }()

    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            textField
        )
    }

    public override func setupLayout() {
        super.setupLayout()
        textField.topToSuperview(offset: 5.0)
        textField.horizontalToSuperview()
        textField.bottomToSuperview(offset: -5.0)
        textField.height(50)
    }

    public override func configureViews() {
        super.configureViews()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DropDownTextField.onViewTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)

        configureTextField()
    }

    public override func styleViews() {
        backgroundColor = .clear

        textField.font = .systemFont(ofSize: 18.0, weight: .light)
        textField.textColor = .black
        textField.backgroundColor = .white
    }

    private func configureTextField() {
        textField.textAlignment = .left
        textField.isUserInteractionEnabled = false
        textField.leftView = nil
        textField.leftViewMode = .never

        let view = UIView(frame: CGRect(x: textField.frame.size.width - 55.0, y: 0.0, width: 55.0, height: 50.0))
        let dropDownImageButton = UIButton()
        dropDownImageButton.contentMode = .scaleToFill
        dropDownImageButton.setImage(R.image.calendar_icon(), for: .normal)
        dropDownImageButton.size(CGSize(width: 55.0, height: 50.0))
        view.add(dropDownImageButton)
        dropDownImageButton.edgesToSuperview()

        textField.rightView = view
        textField.rightViewMode = .always
    }

    @objc private func onViewTap(_ sender: UITapGestureRecognizer) {
        delegate?.onDropDownTapped(inView: self)
    }

}
