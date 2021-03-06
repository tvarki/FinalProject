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

    init(from: SpeedDTO) {
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

    func toString() -> String {
        var res = "Speed".makeBold().addLineBreaker()
        if walk != nil {
            res.append("Wolk: \(walk!)ft.".addLineBreaker())
        }
        if fly != nil {
            res.append("Fly: \(fly!)ft.".addLineBreaker())
        }
        if swim != nil {
            res.append("Swim: \(swim!)ft.".addLineBreaker())
        }
        if climb != nil {
            res.append("Climb: \(climb!)ft.".addLineBreaker())
        }
        return res
    }
}
