//
//  SelectableView.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 29/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppCommon

public protocol SelectableViewDelegate: class {
    func onDateFromSelected(inView view: SelectableView, sender: DropDownTextField)
    func onDateToSelected(inView view: SelectableView, sender: DropDownTextField)
    func onClearTapped(inView view: SelectableView, sender: UIButton)
    func onDownloadTapped(inView view: SelectableView, sender: UIButton)
}

public class SelectableView: BaseView {

    public weak var delegate: SelectableViewDelegate?

    public var dateFromText: String? {
        didSet {
            dateFromDropDown.text = dateFromText
        }
    }

    public var dateToText: String? {
        didSet {
            dateToDropDown.text = dateToText
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var dateFromDropDown: DropDownTextField = {
        let dropDown = DropDownTextField()
        dropDown.tag = 0
        dropDown.delegate = self
        dropDown.placeholder = "Data od"
        return dropDown
    }()

    private lazy var dateToDropDown: DropDownTextField = {
        let dropDown = DropDownTextField()
        dropDown.tag = 1
        dropDown.delegate = self
        dropDown.placeholder = "Data do"
        return dropDown
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Wyczyść".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(SelectableView.onClearTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .blueDisabled
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25.0
        return button
    }()

    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Pobierz".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(SelectableView.onDownloadTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .blueDisabled
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25.0
        return button
    }()

    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            titleLabel,
            dateFromDropDown,
            dateToDropDown,
            clearButton,
            downloadButton
        )
    }

    public override func setupLayout() {
        super.setupLayout()
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 7.5, left: 7.5, bottom: 0.0, right: 7.5))
        
        dateFromDropDown.topToBottom(of: titleLabel, offset: 7.5)
        dateFromDropDown.leadingToSuperview(offset: 7.5)
        
        dateToDropDown.topToBottom(of: titleLabel, offset: 7.5)
        dateToDropDown.leadingToTrailing(of: dateFromDropDown, offset: 7.5)
        dateToDropDown.trailingToSuperview(offset: 7.5)
        dateToDropDown.width(to: dateFromDropDown)
        
        clearButton.topToBottom(of: dateFromDropDown, offset: 15.0)
        clearButton.leadingToSuperview(offset: 7.5)
        clearButton.bottomToSuperview(offset: -7.5)
        clearButton.height(50.0)
        
        downloadButton.topToBottom(of: dateFromDropDown, offset: 15.0)
        downloadButton.leadingToTrailing(of: clearButton, offset: 7.5)
        downloadButton.trailingToSuperview(offset: 7.5)
        downloadButton.bottomToSuperview(offset: -7.5)
        downloadButton.width(to: clearButton)
        downloadButton.height(50.0)
    }

    public override func configureViews() {
        super.configureViews()
    }

    public override func styleViews() {
        super.styleViews()
        backgroundColor = .offWhite
    }

    public func setupView(with viewModel: ExchangeRateDetailsViewModel) {
        titleLabel.text = "Wybierz daty od/do"
    }

    @objc private func onClearTapped(_ sender: UIButton) {
        delegate?.onClearTapped(inView: self, sender: sender)
    }

    @objc private func onDownloadTapped(_ sender: UIButton) {
        delegate?.onDownloadTapped(inView: self, sender: sender)
    }
    
    public func setAvailabilityToButtons(_ available: Bool) {
        clearButton.isEnabled = available
        clearButton.backgroundColor = available ? .blueEnabled : .blueDisabled
        
        downloadButton.isEnabled = available
        downloadButton.backgroundColor = available ? .blueEnabled : .blueDisabled
    }

}

extension SelectableView: DropDownTextFieldDelegate {
    public func onDropDownTapped(inView view: DropDownTextField) {
        if view.tag == 0 {
            delegate?.onDateFromSelected(inView: self, sender: view)
        }
        if view.tag == 1 {
            delegate?.onDateToSelected(inView: self, sender: view)
        }
    }
}
