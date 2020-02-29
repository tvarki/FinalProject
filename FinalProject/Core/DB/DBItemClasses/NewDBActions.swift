//
//  NewDBACtions.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

class NewDBActions: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    var attack_bonus = RealmOptional<Int>()
    @objc dynamic var damage_dice: String?
    var damage_bonus = RealmOptional<Int>()

    init(from: NewDBActions) {
        name = from.name
        desc = from.desc
        attack_bonus = from.attack_bonus
        damage_bonus = from.damage_bonus
        damage_dice = from.damage_dice
    }

    init(from: Actions) {
        name = from.name
        desc = from.desc
        attack_bonus.value = from.attack_bonus
        damage_bonus.value = from.damage_bonus
        damage_dice = from.damage_dice
    }

    init(from: NewActions) {
        name = from.name
        desc = from.desc
        attack_bonus.value = from.attack_bonus
        damage_bonus.value = from.damage_bonus
        damage_dice = from.damage_dice
    }

    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }

    func toString() -> String {
        var res = ""
        res.append("Action: \(name)".makeBold().addLineBreaker())
        res.append("Description: \(desc)".addLineBreaker())
        if attack_bonus.value != nil { res.append("Attack Bonus: \(attack_bonus.value!)".addLineBreaker()) }
        if damage_bonus.value != nil { res.append("DMG bonus: \(damage_bonus.value!)".addLineBreaker()) }
        if damage_dice != nil { res.append("Damage Dice: \(damage_dice!)".addLineBreaker()) }
        return res
    }
}
