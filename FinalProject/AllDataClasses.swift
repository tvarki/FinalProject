//
//  AllDataClasses.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 17.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation



struct Cost: Codable{
    let quantity : Int
    let unit : String
}

struct ClassAPIResource: Codable{

    let index: String
    let `class`: String
    let url : String
}

struct ClassAPIResourceList: Codable{
    let count: Int
    let results: [NamedApiResource]
}


struct Choice : Codable{
    let choose : Int
    let type : String
    let from : [ClassAPIResource]
}

struct NamedApiResource: Codable{
    let index: String?
    let name: String
    let url: String
}

struct CommonReq: Codable{
    let count: Int
    let results:[NamedApiResource]
}

struct MagicSchool: Codable{
    let _id: String?
    let index: String?
    let name: String
    let desc: String?
    let url: String
}

struct DamageType: Codable{
    let _id : String?
    let index: String?
    let name: String
    let desc: [String]?
    let url: String
}

struct Condition: Codable {
    let _id : String
    let index: String
    let name: String
    let desc: [String]
    let url: String
}

struct ArmorClass: Codable{
    let base: Int
    let dex_bonus: Bool
    let max_bonus: Int?
}

struct Armor:Codable{
    let _id : String
    let index: String
    let name: String
    let equipment_category: String
    let armor_class: ArmorClass
    let str_minimum: Int
    let stealth_disadvantage: Bool
    let weight: Int
    let cost: Cost
    let url: String
}

struct  Weapon: Codable {
    let _id : String
    let index: String
    let name: String
    let equipment_category: String
    let weapon_category: String
    let weapon_range: String
    let category_range: String
    let cost: Cost
    let damage: Damage
    let range : Range
    let weight: Int
    let properties : [NamedApiResource]
    let url: String
}

struct Damage: Codable{
    let damage_dice: String
    let damage_bonus: Int
    let damage_type: DamageType
}

struct Range: Codable{
    let normal: Int
    let long: Int?
}

struct Skill: Codable {
    let _id : String
    let index: String
    let name: String
    let desc: [String]
    let ability_score: NamedApiResource
    let url: String
}

struct AbilityScores: Codable{
    let _id : String
    let index: String
    let name: String
    let full_name: String
    let desc: [String]
    let skills: [NamedApiResource]
    let url: String
    
}

struct Classes:Codable{
    let name: String
    let url: String
}

struct Subclasses:Codable{
    let name: String
    let url: String
}

struct Spell: Codable{
    let _id : String
    let index: String
    let name: String
    let full_name: String?
    let desc: [String]
    let higher_level: [String]?
    let page: String
    let range: String
    let components:[String]
    let material: String
    let ritual: Bool
    let duration: String
    let concentration: Bool
    let casting_time: String
    let level: Int
    let classes: [Classes]
    let subclasses:[Subclasses]
    let url: String
}


struct Speed: Codable{
    let walk: String?
    let fly: String?
    let swim: String?
}

struct Proficiencies: Codable{
    let name: String
    let url: String
    let value: Int
}

struct Senses: Codable {
    let blindsight: String?
    let darkvision: String?
    let passive_perception: Int?
}

struct Usage: Codable  {
    let type: String
    let times: Int?
    let rest_types: [String]?
}

struct SpecialAbilities: Codable{
    let name: String
    let desc: String
    let usage: Usage?
    let damage: [Damage]?
    
}

struct Actions: Codable{
    let name: String
    let desc: String
}

//MARK:- Monster struct for json
struct Monster: Codable{
    let _id: String
    let index: String
    let name: String
    let size: String
    let type: String
    let subtype: String?
    let alignment: String
    let armor_class: Int
    let hit_points: Int
    let hit_dice: String
    let speed: Speed
    let strength: Int
    let dexterity: Int
    let constitution: Int
    let intelligence: Int
    let wisdom: Int
    let charisma: Int
    let proficiencies: [Proficiencies]
    let damage_vulnerabilities: [String]
    let damage_resistances: [String]
    let damage_immunities: [String]
    let condition_immunities: [ConditionImmunities]
    let senses: Senses
    let languages : String
    let challenge_rating : Double?
    let special_abilities: [SpecialAbilities]?
    let actions: [Actions]?
    let legendary_actions : [Actions]?
    let url: String
    
}


struct ConditionImmunities: Codable{
    let name: String
    let url: String
}
