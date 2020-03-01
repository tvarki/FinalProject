//
//  NewCommonReq.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct DTOCommonReq: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [DTOMonster]
}
