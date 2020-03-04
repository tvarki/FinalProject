//
//  AbilityScore.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 04.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct AbilityScore {
    let name: String
    let value: String

    init(name: String, value: Int) {
        self.name = name
        self.value = "\(value) (\(AbilityScore.getMod(mod: value)))"
    }

    static func getMod(mod: Int) -> String {
        if mod >= 10 {
            return "+\((mod - 10) / 2)"
        } else {
            return "-\((11 - mod) / 2)"
        }
    }
}
