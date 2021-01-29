//
//  ExchangeRateCell.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

import ExchangeRateAppViewModel
import ExchangeRateAppCommon

public class ExchangeRateCell: UITableViewCell {

    private lazy var shadowView: ShadowView = {
        let view = ShadowView(shadowColor: .black,
                              shadowOffset: CGSize(width: 3.5,height: 3.5),
                              shadowOpacity: 0.5,
                              shadowRadius: 2.0,
                              cornerRadius: 7.0)
        view.backgroundColor = .white
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 7.0
        view.backgroundColor = .white
        return view
    }()

    private lazy var exchangeRateCodeCurrencyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .blackDisabled
        return label
    }()

    private lazy var exchangeRateDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .blackDisabled
        return label
    }()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sharedInit()
    }

    private func sharedInit() {
        createViewsHierarchy()
        setupLayout()
        configureViews()
    }

    private func createViewsHierarchy() {
        contentView.add(
            shadowView.add(
                containerView.add(
                    exchangeRateCodeCurrencyNameLabel,
                    exchangeRateLabel,
                    exchangeRateDateLabel
                )
            )
        )
    }

    private func setupLayout() {
        shadowView.edgesToSuperview(insets: .init(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5))
        
        containerView.edgesToSuperview()
        
        exchangeRateCodeCurrencyNameLabel.topToSuperview(offset: 22.5)
        exchangeRateCodeCurrencyNameLabel.leadingToSuperview(offset: 30.0)
        exchangeRateCodeCurrencyNameLabel.trailingToSuperview(offset: 30.0)
        exchangeRateCodeCurrencyNameLabel.setHugging(.init(200), for: .vertical)

        exchangeRateLabel.topToBottom(of: exchangeRateCodeCurrencyNameLabel, offset: 15.0)
        exchangeRateLabel.leading(to: exchangeRateCodeCurrencyNameLabel)
        exchangeRateLabel.bottomToSuperview(offset: -22.5)

        exchangeRateDateLabel.topToBottom(of: exchangeRateCodeCurrencyNameLabel, offset: 15.0)
        exchangeRateDateLabel.leadingToTrailing(of: exchangeRateLabel)
        exchangeRateDateLabel.trailing(to: exchangeRateCodeCurrencyNameLabel)
        exchangeRateDateLabel.bottomToSuperview(offset: -22.5)
        exchangeRateDateLabel.width(to: exchangeRateLabel)
    }

    private func configureViews() {
        selectionStyle = .none
    }

    public func setupCell(with viewModel: ExchangeRateCellViewModel?) {
        guard let viewModel = viewModel else { return }
        exchangeRateCodeCurrencyNameLabel.text = viewModel.exchangeRateCodeCurrencyName
        exchangeRateLabel.text = viewModel.averageExchangeRate
        exchangeRateDateLabel.text = viewModel.exchangeRateDate
    }

    public func changeCellBackgroundColorIfNeeded(_ isNeeded: Bool) {
        containerView.backgroundColor = isNeeded ? .offWhite : .white
    }

}
