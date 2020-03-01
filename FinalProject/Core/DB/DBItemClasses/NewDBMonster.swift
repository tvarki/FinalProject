//
//  DBItem.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 26.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - MyObject - protocol

protocol MyDBObject: Object {
    dynamic var name: String { get set }
    dynamic var isFavorite: Bool { get set }
    //    dynamic var mainLabel: String { get set }
    func getCellData() -> [String]
}

class NewDBMonster: Object, MyDBObject {
    @objc dynamic var slug: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var subtype: String?
    @objc dynamic var group: String?
    @objc dynamic var alignment: String = ""
    @objc dynamic var armor_class: Int = 0
    @objc dynamic var armor_desc: String?
    @objc dynamic var hit_points: Int = 0
    @objc dynamic var hit_dice: String = ""
    @objc dynamic var speed: NewDBSpeed?
    @objc dynamic var strength: Int = 0
    @objc dynamic var dexterity: Int = 0
    @objc dynamic var constitution: Int = 0
    @objc dynamic var intelligence: Int = 0
    @objc dynamic var wisdom: Int = 0
    @objc dynamic var charisma: Int = 0
    var strength_save = RealmOptional<Int>()
    var dexterity_save = RealmOptional<Int>()
    var constitution_save = RealmOptional<Int>()
    var intelligence_save = RealmOptional<Int>()
    var wisdom_save = RealmOptional<Int>()
    var charisma_save = RealmOptional<Int>()
    var perception = RealmOptional<Int>()
    @objc dynamic var damage_vulnerabilities: String = ""
    @objc dynamic var damage_resistances: String = ""
    @objc dynamic var damage_immunities: String = ""
    @objc dynamic var condition_immunities: String?
    @objc dynamic var senses: String?
    @objc dynamic var languages: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var challenge_rating: String?

    var special_abilities = List<NewDBActions>()
    var actions = List<NewDBActions>()
    var legendary_actions = List<NewDBActions>()

    @objc dynamic var legendary_desc: String?
    var spell_list = List<String>()
    @objc dynamic var img_main: String?

    override static func primaryKey() -> String? {
        return "name"
    }

    init(from: DTOMonster) {
        let special_abilities = List<NewDBActions>()
        let tmp = NewDBMonster.castAnyObjectToNewDBActions(action: from.special_abilities)
        tmp.forEach { action in special_abilities.append(NewDBActions(from: action)) }

        let actions = List<NewDBActions>()
        let tmp2 = NewDBMonster.castAnyObjectToNewDBActions(action: from.actions)
        tmp2.forEach { action in actions.append(NewDBActions(from: action)) }

        let legendary_actions = List<NewDBActions>()
        let tmp3 = NewDBMonster.castAnyObjectToNewDBActions(action: from.legendary_actions)
        tmp3.forEach { action in legendary_actions.append(NewDBActions(from: action)) }

        slug = from.slug
        name = from.name
        size = from.size
        type = from.type
        subtype = from.subtype
        alignment = from.alignment
        armor_class = from.armor_class
        hit_points = from.hit_points
        hit_dice = from.hit_dice
        speed = NewDBSpeed(from: from.speed)
        strength = from.strength
        dexterity = from.dexterity
        constitution = from.constitution
        intelligence = from.intelligence
        wisdom = from.wisdom
        charisma = from.charisma
        strength_save.value = from.strength_save
        dexterity_save.value = from.dexterity_save
        constitution_save.value = from.constitution_save
        intelligence_save.value = from.intelligence_save
        wisdom_save.value = from.wisdom_save
        charisma_save.value = from.charisma_save
        perception.value = from.perception
        damage_vulnerabilities = from.damage_vulnerabilities
        damage_resistances = from.damage_resistances
        damage_immunities = from.damage_immunities
        condition_immunities = from.condition_immunities
        senses = from.senses
        languages = from.languages
        challenge_rating = from.challenge_rating

        self.special_abilities = special_abilities
        self.actions = actions
        self.legendary_actions = legendary_actions
        img_main = from.img_main
    }

    init(from: MonsterItem) {
        let special_abilities = List<NewDBActions>()
//        var tmp = NewDBMonster.castAnyObjectToNewDBActions(action: from.special_abilities)
        from.special_abilities.forEach { action in special_abilities.append(NewDBActions(from: action)) }

        let actions = List<NewDBActions>()
//        tmp = NewDBMonster.castAnyObjectToNewDBActions(action: from.actions)
        from.actions.forEach { action in actions.append(NewDBActions(from: action)) }

        let legendary_actions = List<NewDBActions>()
//        tmp = NewDBMonster.castAnyObjectToNewDBActions(action: from.legendary_actions)
        from.legendary_actions.forEach { action in legendary_actions.append(NewDBActions(from: action)) }

        slug = from.slug
        name = from.name
        size = from.size
        type = from.type
        subtype = from.subtype
        alignment = from.alignment
        armor_class = from.armor_class
        hit_points = from.hit_points
        hit_dice = from.hit_dice
        speed = NewDBSpeed(from: from.speed)
        strength = from.strength
        dexterity = from.dexterity
        constitution = from.constitution
        intelligence = from.intelligence
        wisdom = from.wisdom
        charisma = from.charisma
        strength_save.value = from.strength_save
        dexterity_save.value = from.dexterity_save
        constitution_save.value = from.constitution_save
        intelligence_save.value = from.intelligence_save
        wisdom_save.value = from.wisdom_save
        charisma_save.value = from.charisma_save
        perception.value = from.perception
        damage_vulnerabilities = from.damage_vulnerabilities
        damage_resistances = from.damage_resistances
        damage_immunities = from.damage_immunities
        condition_immunities = from.condition_immunities
        senses = from.senses
        languages = from.languages
        challenge_rating = from.challenge_rating
        isFavorite = from.isFavorite
        self.special_abilities = special_abilities
        self.actions = actions
        self.legendary_actions = legendary_actions
        img_main = from.img_main
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
        speed = from.speed
        strength = from.strength
        dexterity = from.dexterity
        constitution = from.constitution
        intelligence = from.intelligence

        dexterity_save = from.dexterity_save
        constitution_save = from.constitution_save
        intelligence_save = from.intelligence_save
        wisdom_save = from.wisdom_save
        charisma_save = from.charisma_save
        perception = from.perception

        wisdom = from.wisdom
        charisma = from.charisma
        damage_vulnerabilities = from.damage_vulnerabilities
        damage_resistances = from.damage_resistances
        damage_immunities = from.damage_immunities
        condition_immunities = from.condition_immunities
        senses = from.senses
        languages = from.languages
        challenge_rating = from.challenge_rating
        special_abilities = from.special_abilities
        actions = from.actions
        legendary_actions = from.legendary_actions

        img_main = from.img_main
        isFavorite = from.isFavorite
    }

    required init() {}

    // MARK: - DBMonster.toString()

    func getCellData() -> [String] {
        var res: [String] = []
        let name = "\(self.name)"
//        let index = "\(self.index)"
        let hp = "🩸: \(hit_points) 🛡: \(armor_class) 🎚: \(challenge_rating!)"
        let ac = "AC: \(armor_class)"

        res.append(name)
//        res.append(index)
        res.append(hp)
        res.append(ac)

        return res
    }

    static func castAnyObjectToNewDBActions(action: DTOJSONAny) -> List<NewDBActions> {
        var tmp: [DTOActions]?
        tmp = action.value as? [DTOActions]
        let result = List<NewDBActions>()
        if tmp != nil {
            tmp!.forEach { action in
                result.append(NewDBActions(from: action))
            }
        }
        return result
    }
}
