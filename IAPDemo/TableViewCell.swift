//
//  TableViewCell.swift
//  IAPDemo
//
//  Created by trinh.hoang.hai on 5/28/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import UIKit
import StoreKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var product: SKProduct?

    @IBAction func buyAction(_ sender: Any) {
        guard let product = product else { return }
        IAPHelper.shared.buyProduct(product)
    }

    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency

        return formatter
    }()

    func configCell(product: SKProduct) {
        self.product = product
        nameLabel?.text = product.localizedTitle

        if IAPHelper.shared.isProductPurchased(product.productIdentifier) {
            accessoryType = .checkmark
            accessoryView = nil
            detailTextLabel?.text = ""
        } else if IAPHelper.canMakePayments() {
            TableViewCell.priceFormatter.locale = product.priceLocale
            priceLabel?.text = TableViewCell.priceFormatter.string(from: product.price)

            accessoryType = .none
            accessoryView = nil
        } else {
            priceLabel?.text = "Not available"
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        priceLabel.text = nil
        accessoryView = nil
    }
}
