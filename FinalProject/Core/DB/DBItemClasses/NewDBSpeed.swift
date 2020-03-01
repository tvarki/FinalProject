//
//  NewDBSpeed.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

class NewDBSpeed: Object {
    var walk = RealmOptional<Int>()
    var fly = RealmOptional<Int>()
    var swim = RealmOptional<Int>()
    var climb = RealmOptional<Int>()

    init(from: SpeedDTO) {
        walk.value = from.walk
        fly.value = from.fly
        swim.value = from.swim
        climb.value = from.climb
    }

    init(from: Speed) {
        walk.value = from.walk
        fly.value = from.fly
        swim.value = from.swim
        climb.value = from.climb
    }

    required init() {
        super.init()
        walk.value = nil
        fly.value = nil
        swim.value = nil
        climb.value = nil
        //        fatalError("init() has not been implemented")
    }
}
