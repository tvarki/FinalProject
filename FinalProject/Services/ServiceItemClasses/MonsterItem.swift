//
//  ServiceItemClasses.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class MonsterItem {
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
    let speed: Speed
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

    var special_abilities: [Actions]
    let actions: [Actions]
    let legendary_desc: String?
    var legendary_actions: [Actions]

    let spell_list: [String]?

    let img_main: String?
    var isFavorite: Bool = false

    init(from: DTOMonster) {
        slug = from.slug
        name = from.name
        size = from.size
        type = from.type
        subtype = from.subtype
        alignment = from.alignment
        armor_class = from.armor_class
        hit_points = from.hit_points
        hit_dice = from.hit_dice
        speed = Speed(from: from.speed)
        strength = from.strength
        dexterity = from.dexterity
        constitution = from.constitution
        intelligence = from.intelligence
        wisdom = from.wisdom
        charisma = from.charisma
        strength_save = from.strength_save
        dexterity_save = from.dexterity_save
        constitution_save = from.constitution_save
        intelligence_save = from.intelligence_save
        wisdom_save = from.wisdom_save
        charisma_save = from.charisma_save
        perception = from.perception
        damage_vulnerabilities = from.damage_vulnerabilities
        damage_resistances = from.damage_resistances
        damage_immunities = from.damage_immunities
        condition_immunities = from.condition_immunities
        senses = from.senses
        languages = from.languages
        challenge_rating = from.challenge_rating

        special_abilities = MonsterItem.castAnyObjectToActions(action: from.special_abilities)
        actions = MonsterItem.castAnyObjectToActions(action: from.actions)
        legendary_actions = MonsterItem.castAnyObjectToActions(action: from.legendary_actions)
        legendary_desc = from.legendary_desc
        spell_list = from.spell_list
        img_main = from.img_main
        armor_desc = from.armor_desc
        group = from.group
    }

    init(from: NewDBMonster) {
        slug = from.slug
        name = from.name
        size = from.size
        type = from.type
        subtype = from.subtype
        alignment = from.alignment
        armor_class = from.armor_class
        hit_points = from.hit_points
        hit_dice = from.hit_dice
        speed = Speed(from: from.speed ?? NewDBSpeed())
        strength = from.strength
        dexterity = from.dexterity
        constitution = from.constitution
        intelligence = from.intelligence

        strength_save = from.strength_save.value
        dexterity_save = from.dexterity_save.value
        constitution_save = from.constitution_save.value
        intelligence_save = from.intelligence_save.value
        wisdom_save = from.wisdom_save.value
        charisma_save = from.charisma_save.value
        perception = from.perception.value

        wisdom = from.wisdom
        charisma = from.charisma
        damage_vulnerabilities = from.damage_vulnerabilities
        damage_resistances = from.damage_resistances
        damage_immunities = from.damage_immunities
        condition_immunities = from.condition_immunities
        senses = from.senses
        languages = from.languages
        challenge_rating = from.challenge_rating

        var tmp_special_abilities: [Actions] = []
        from.special_abilities.forEach { action in tmp_special_abilities.append(Actions(from: action)) }
        special_abilities = tmp_special_abilities

        var tmp_legendary_actions: [Actions] = []
        from.legendary_actions.forEach { action in tmp_legendary_actions.append(Actions(from: action)) }
        legendary_actions = tmp_legendary_actions

        var tmp_actions: [Actions] = []
        from.actions.forEach { action in tmp_actions.append(Actions(from: action)) }
        actions = tmp_actions

        group = from.group
        armor_desc = from.armor_desc
        legendary_desc = from.legendary_desc
        img_main = from.img_main
        isFavorite = from.isFavorite
        var tmp_spell_list: [String] = []
        from.spell_list.forEach { spell in tmp_spell_list.append(spell) }
        spell_list = tmp_spell_list
    }

    static func castAnyObjectToActions(action: DTOJSONAny) -> [Actions] {
        var tmp: [Actions]?
        tmp = action.value as? [Actions]
        if tmp != nil {
            return tmp!
        }
        return []
    }

    func getName() -> String {
        return name
    }

    func getDetail() -> String {
        return "🩸: \(hit_points) 🛡: \(armor_class) 🎚: \(challenge_rating!)"
    }

//    func getCellData() -> [String] {
//        var res: [String] = []
//        let name = "\(self.name)"
//        //        let index = "\(self.index)"
//        let hp = "🩸: \(hit_points) 🛡: \(armor_class) 🎚: \(challenge_rating!)"
//        let ac = "AC: \(armor_class)"
//
//        res.append(name)
//        //        res.append(index)
//        res.append(hp)
//        res.append(ac)
//
//        return res
//    }

    func toString() -> String {
        var res = ""
        let name = "\(self.name.makeBold().addLineBreaker())"

        let sz = "Size: \(size.addLineBreaker())"
        let type = "Type: \(self.type.addLineBreaker())"
        let hp = "Hit Points: \(String(hit_points).addLineBreaker())"
        let ac = "Armor Class: \(String(armor_class).addLineBreaker())"

        let str = "Str: \(String(strength).addLineBreaker())"
        let dex = "Dex: \(String(dexterity).addLineBreaker())"
        let con = "Con: \(String(constitution).addLineBreaker())"
        let int = "Int: \(String(intelligence).addLineBreaker())"
        let wis = "Wis: \(String(wisdom).addLineBreaker())"
        let char = "Char: \(String(charisma).addLineBreaker())"

        let lb = "".addLineBreaker()

        let strSave = "Str Save: \(String(strength_save ?? 0).addLineBreaker())"
        let dexSave = "Dex Save: \(String(dexterity_save ?? 0).addLineBreaker())"
        let conSave = "Con Save: \(String(constitution_save ?? 0).addLineBreaker())"
        let intSave = "Int Save: \(String(intelligence_save ?? 0).addLineBreaker())"
        let wisSave = "Wis Save: \(String(wisdom_save ?? 0).addLineBreaker())"
        let charSave = "Char Save: \(String(charisma_save ?? 0).addLineBreaker())"

        let perseption = "Perseprion: \(String(perception ?? 0).addLineBreaker())"

        let damage_vulnerabilities = "Damage Vulnerabilities: \(self.damage_vulnerabilities.addLineBreaker())"
        let damage_resistances = "Damage Resistances: \(self.damage_resistances.addLineBreaker())"
        let damage_immunities = "Damage Immunities: \(self.damage_immunities.addLineBreaker())"
        let senses = "Senses \((self.senses ?? "-").addLineBreaker())"
        let languages = "Languages: \(self.languages)".addLineBreaker()
        var challenge_rating = ""
        if self.challenge_rating != nil {
            challenge_rating.append("Challenge Rating: ".makeBold())
            challenge_rating.append("\(String(describing: self.challenge_rating!))".addLineBreaker())
        }
        let actions = self.actions.toString(type: .Actions)
        let special_abilities = self.special_abilities.toString(type: .SpecialAbilities)
        var legendary_descr = ""
        if legendary_desc != nil { legendary_descr = "Legendary Description \(legendary_desc!)" }
        let legendaryActions = legendary_actions.toString(type: .LegendaryActions)

        res.append(name)
        res.append(sz)
        res.append(type)
        res.append(hp)
        res.append(ac)
        res.append(lb)
        res.append(str)
        res.append(dex)
        res.append(con)
        res.append(int)
        res.append(wis)
        res.append(char)
        res.append(lb)
        res.append(strSave)
        res.append(dexSave)
        res.append(conSave)
        res.append(intSave)
        res.append(wisSave)
        res.append(charSave)
        res.append(perseption)
        res.append(lb)
        res.append(damage_vulnerabilities)
        res.append(damage_resistances)
        res.append(damage_immunities)
        res.append(lb)
        res.append(senses)
        res.append(languages)
        res.append(challenge_rating)
        res.append(actions)
        res.append(special_abilities)
        res.append(legendary_descr)
        res.append(legendary_descr)
        res.append(legendaryActions)

        return res
    }
}
