//
//  EnumMonsterParametrs.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

enum EnumMonsterParametrs: String {
    case name = "Name"
    case challenge_rating = "Challenge Rating"
    case size = "Size"
    case type = "Type"
    case other

    static func getArray() -> [String] {
        let tmp = ["Name", "Challenge Rating", "Size", "Type"]
        return tmp.sorted()
    }
}
