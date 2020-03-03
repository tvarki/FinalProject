//
//  EnumMagicItemParams.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

enum EnumMagicItemParams: String {
    case name = "Name"
    case rarity = "Rarity"
    case other

    static func getArray() -> [String] {
        let tmp = ["Name", "Rarity"]
        return tmp.sorted()
    }
}
