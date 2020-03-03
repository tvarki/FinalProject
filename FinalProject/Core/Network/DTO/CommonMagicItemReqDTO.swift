//
//  CommonMagicItemReqDTO.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct CommonMagicItemReqDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [MagicItemDTO]
}
