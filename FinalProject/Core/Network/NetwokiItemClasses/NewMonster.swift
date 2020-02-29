//
//  AllDataClasses.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 17.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct NewMonster: Codable {
    let slug: String
    let name: String
    let size: String
    let type: String
    let subtype: String?
    let group: String?
    let alignment: String
    let armor_class: Int
    let armor_desc: String?
    let hit_points: Int
    let hit_dice: String
    let speed: NewSpeed
    let strength: Int
    let dexterity: Int
    let constitution: Int
    let intelligence: Int
    let wisdom: Int
    let charisma: Int

    let strength_save: Int?
    let dexterity_save: Int?
    let constitution_save: Int?
    let intelligence_save: Int?
    let wisdom_save: Int?
    let charisma_save: Int?
    let perception: Int?

//    let proficiencies: [Proficiencies]
    let damage_vulnerabilities: String
    let damage_resistances: String
    let damage_immunities: String

    let condition_immunities: String?
    let senses: String?
    let languages: String
    let challenge_rating: String?

    let special_abilities: JSONAny
    let actions: JSONAny
    let legendary_desc: String?

    let legendary_actions: JSONAny

    let spell_list: [String]

    let img_main: String?
}
