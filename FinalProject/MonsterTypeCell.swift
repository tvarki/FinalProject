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
    
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setup(type: String) {
        typeLabel.text = type
        typeLabel.layer.masksToBounds = true
//        typeLabel.layer.cornerRadius = 10
        typeLabel.textColor = UIColor.systemBlue
//        typeLabel.backgroundColor = UIColor.systemGray2
    }
            
}
