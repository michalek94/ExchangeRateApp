//
//  DatePickerView.swift
//  ExchangeRateAppViewViewModel
//
//  Created by Michał Pankowski on 28/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import TinyConstraints

public protocol DatePickerViewDelegate: class {
    func onSaveTapped()
    func onDismissTapped()
}

public class DatePickerView: UIView {

    public weak var delegate: DatePickerViewDelegate?

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let emptyItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let saveItem = UIBarButtonItem(title: viewModel.actionTitle, style: .done, target: self, action: #selector(DatePickerView.save(_:)))
        toolbar.setItems([emptyItem, saveItem], animated: false)
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.backgroundColor = .white
        toolbar.tintColor = .black
        return toolbar
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) { datePicker.preferredDatePickerStyle = .wheels }
        if let date = viewModel.date { datePicker.date = date }
        datePicker.minimumDate = viewModel.minimumDate
        datePicker.maximumDate = viewModel.maximumDate
        datePicker.backgroundColor = .white
        return datePicker
    }()

    private let viewModel: DatePickerViewModel

    public init(viewModel: DatePickerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        createViewHierarchy()
        setupLayout()
        configureViews()
        styleViews()
    }

    required init?(coder aDecoder: NSCoder) { nil }

    private func createViewHierarchy() {
        add(
            toolbar,
            datePicker,
            separatorView
        )
    }

    private func setupLayout() {
        toolbar.edgesToSuperview(excluding: [.top, .bottom])

        separatorView.edgesToSuperview(excluding: [.top, .bottom])
        separatorView.topToBottom(of: toolbar)
        separatorView.height(1.0)

        datePicker.edgesToSuperview(excluding: .top)
        datePicker.topToBottom(of: toolbar)
    }

    private func configureViews() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DatePickerView.backgroundTapped(_:)))
        addGestureRecognizer(tapRecognizer)
    }

    private func styleViews() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    @objc private func save(_ sender: UIBarButtonItem) {
        delegate?.onSaveTapped()
        viewModel.dateSelected(datePicker.date)
    }

    @objc private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        delegate?.onDismissTapped()
        viewModel.dismiss()
    }

}
