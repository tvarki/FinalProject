//
//  MagicItemDTO.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct MagicItemDTO: Codable {
    let slug: String
    let name: String
    let type: String
    let desc: String
    let rarity: String
    let requires_attunement: String
    let document__slug: String
    let document__title: String
}
