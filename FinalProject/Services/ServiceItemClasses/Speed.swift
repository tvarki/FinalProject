//
//  Speed.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct Speed {
    let walk: Int?
    let fly: Int?
    let swim: Int?
    let climb: Int?

    init(from: NewSpeed) {
        walk = from.walk
        fly = from.fly
        swim = from.swim
        climb = from.climb
    }

    init(from: NewDBSpeed) {
        walk = from.walk.value
        fly = from.fly.value
        swim = from.swim.value
        climb = from.climb.value
    }
}
