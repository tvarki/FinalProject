//
//  NewAction.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct NewActions: Codable {
    let name: String
    let desc: String
    let attack_bonus: Int?
    let damage_dice: String?
    let damage_bonus: Int?
}
