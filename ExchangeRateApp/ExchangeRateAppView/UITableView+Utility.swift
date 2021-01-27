//
//  UITableView+Utility.swift
//  ExchangeRateAppView
//
//  Created by Michał Pankowski on 27/01/2021.
//  Copyright © 2021 Michał Pankowski. All rights reserved.
//

protocol CellIdentifiable {
    static var identifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: CellIdentifiable { }

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Error occurred while dequeuing cell for identifier \(T.identifier)")
        }
        return cell
    }
}
