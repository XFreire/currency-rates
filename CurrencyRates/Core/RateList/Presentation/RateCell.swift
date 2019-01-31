//
//  RateCell.swift
//  Core
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class RateCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func prepareForReuse() {
        titleLabel.text = nil
        subtitleLabel.text = nil
        textField.text = nil
        textField.isUserInteractionEnabled = false
    }
}
