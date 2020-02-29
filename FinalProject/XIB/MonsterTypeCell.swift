//
//  MonsterTypeCell.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 14.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class MonsterTypeCell: UICollectionViewCell {
    //    private var state : MonsterTypeCellState = .passive

    @IBOutlet var typeLabel: UILabel!
    var mySelected: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(type: String) {
        typeLabel.text = type
        typeLabel.layer.masksToBounds = true
        typeLabel.layer.cornerRadius = 5
    }

    func mySelect() {
        switch mySelected {
        case false:
            mySelected = true
            typeLabel.backgroundColor = .systemBlue
        case true:
            mySelected = false
            typeLabel.backgroundColor = .systemGray
        }
    }

    func setSelected() {
        mySelected = true
        typeLabel.backgroundColor = .systemBlue
    }

    func getText() -> String {
        return typeLabel.text ?? ""
    }
}

enum CellBackgroundColor {
    case White
    case Blue
}
