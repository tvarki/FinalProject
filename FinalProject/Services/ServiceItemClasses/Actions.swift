//
//  Actions.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct Actions {
    let name: String
    let desc: String
    let attack_bonus: Int?
    let damage_dice: String?
    let damage_bonus: Int?
    init(from: NewDBActions) {
        name = from.name
        desc = from.desc
        attack_bonus = from.attack_bonus.value
        damage_dice = from.damage_dice
        damage_bonus = from.damage_bonus.value
    }

    func toString(type: ActionsType) -> String {
        var res = ""
        switch type {
        case .Actions:
            res.append("Action: \(name)".makeBold().addLineBreaker())
        case .LegendaryActions:
            res.append("Legendary Action: \(name)".makeBold().addLineBreaker())
        case .SpecialAbilities:
            res.append("Special Ability: \(name)".makeBold().addLineBreaker())
        }
//        res.append("Action: \(name)".makeBold().addLineBreaker())
        res.append("Description: \(desc)".addLineBreaker())
        if attack_bonus != nil { res.append("Attack Bonus: \(attack_bonus!)".addLineBreaker()) }
        if damage_bonus != nil { res.append("DMG bonus: \(damage_bonus!)".addLineBreaker()) }
        if damage_dice != nil { res.append("Damage Dice: \(damage_dice!)".addLineBreaker()) }
        return res
    }
}
