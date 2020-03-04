//
//  AbilityScoreCollectionViewCell.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 04.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class AbilityScoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet var aScoreTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        aScoreTextField.isEnabled = false
        valueTextField.isEnabled = false
        // Initialization code
    }

    func setParams(aScore: String, value: String) {
        aScoreTextField.text = aScore
        valueTextField.text = value
    }
}
