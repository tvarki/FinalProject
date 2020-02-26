//
//  DBItem.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 26.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

//MARK:- MyObject - protocol
protocol MyDBObject: Object{
    dynamic var name: String { get set }
    dynamic var isFavorite: Bool { get set }
    //    dynamic var mainLabel: String { get set }
    func toString()->String
    func getCellData()->[String]
    
}
//MARK:- DBMonster - class for DataBase
//class DBMonster: Object, MyDBObject{
//
//    @objc dynamic var _id: String = ""
//    @objc dynamic var index: String = ""
//    @objc dynamic var name: String = ""
//    @objc dynamic var size: String = ""
//    @objc dynamic var type: String = ""
//    @objc dynamic var subtype: String? = nil
//    @objc dynamic var alignment: String = ""
//    @objc dynamic var armor_class: Int = 0
//    @objc dynamic var hit_points: Int = 0
//    @objc dynamic var hit_dice: String = ""
//    //    let speed: Speed
//    @objc dynamic var strength: Int = 0
//    @objc dynamic var dexterity: Int = 0
//    @objc dynamic var constitution: Int = 0
//    @objc dynamic var intelligence: Int = 0
//    @objc dynamic var wisdom: Int = 0
//    @objc dynamic var charisma: Int = 0
//    var proficiencies = List<DBProficiencies>()
//    var damage_vulnerabilities = List<String>()
//    var damage_resistances = List<String>()
//    var damage_immunities = List<String>()
//    var condition_immunities :List<DBConditionImmunities> = List<DBConditionImmunities>()
//    @objc dynamic var senses: DBSenses? = nil
//    @objc dynamic var languages : String = ""
//
//
//    @objc dynamic var isFavorite: Bool = false
//
//
//    var challenge_rating = RealmOptional<Double>()
//    var special_abilities = List<DBSpecialAbilities>()
//    var actions = List<DBActions>()
//    var legendary_actions = List<DBActions>()
//    @objc dynamic var url: String = ""
//
//    override static func primaryKey() -> String? {
//        return "index"
//    }
//
//    init (from: Monster){
//
//        let damage_vulnerabilities = List<String>()
//        for str in from.damage_vulnerabilities{
//            damage_vulnerabilities.append(str)
//        }
//
//        let damage_resistances = List<String>()
//        for str in from.damage_resistances{
//            damage_resistances.append(str)
//        }
//
//        let damage_immunities = List<String>()
//        for str in from.damage_immunities{
//            damage_immunities.append(str)
//        }
//
//        let condition_immunities = List<DBConditionImmunities>()
//        //        if from.condition_immunities != nil {
//        for str in from.condition_immunities{
//            condition_immunities.append(DBConditionImmunities(from: str))
//        }
//        //        }
//
//        let proficiencies = List<DBProficiencies>()
//        for str in from.proficiencies{
//            proficiencies.append(DBProficiencies(from: str))
//        }
//
//        let special_abilities = List<DBSpecialAbilities>()
//        if from.special_abilities != nil {
//            for str in from.special_abilities!{
//                special_abilities.append(DBSpecialAbilities(from: str))
//            }
//        }
//
//        let actions = List<DBActions>()
//        if from.actions != nil {
//            for str in from.actions!{
//                actions.append(DBActions(from: str))
//            }
//        }
//        let legendary_actions = List<DBActions>()
//        if from.legendary_actions != nil {
//            for str in from.legendary_actions!{
//                legendary_actions.append(DBActions(from: str))
//            }
//        }
//        self._id = from._id
//        self.index = from.index
//        self.name = from.name
//        self.size = from.size
//        self.type = from.type
//        self.subtype = from.subtype
//        self.alignment = from.alignment
//        self.armor_class = from.armor_class
//        self.hit_points = from.hit_points
//        self.hit_dice = from.hit_dice
//        //    let speed: Speed
//        self.strength = from.strength
//        self.dexterity = from.dexterity
//        self.constitution = from.constitution
//        self.intelligence = from.intelligence
//        self.wisdom = from.wisdom
//        self.charisma = from.charisma
//        self.proficiencies = proficiencies
//        self.damage_vulnerabilities = damage_vulnerabilities
//        self.damage_resistances = damage_resistances
//        self.damage_immunities = damage_immunities
//        self.condition_immunities = condition_immunities
//        self.senses = DBSenses(from: from.senses)
//        self.languages  = from.languages
//        self.challenge_rating.value = from.challenge_rating!
//        self.special_abilities = special_abilities
//        self.actions = actions
//        self.legendary_actions = legendary_actions
//        self.url = from.url
//
//
//    }
//
//    init (from: DBMonster){
//
//        let damage_vulnerabilities = from.damage_vulnerabilities
//        let damage_resistances = from.damage_resistances
//        let damage_immunities = from.damage_immunities
//        let condition_immunities = from.condition_immunities
//        let proficiencies = from.proficiencies
//        let special_abilities = from.special_abilities
//        let actions = from.actions
//        let legendary_actions = from.legendary_actions
//        self._id = from._id
//        self.index = from.index
//        self.name = from.name
//        self.size = from.size
//        self.type = from.type
//        self.subtype = from.subtype
//        self.alignment = from.alignment
//        self.armor_class = from.armor_class
//        self.hit_points = from.hit_points
//        self.hit_dice = from.hit_dice
//        //    let speed: Speed
//        self.strength = from.strength
//        self.dexterity = from.dexterity
//        self.constitution = from.constitution
//        self.intelligence = from.intelligence
//        self.wisdom = from.wisdom
//        self.charisma = from.charisma
//        self.proficiencies = proficiencies
//        self.damage_vulnerabilities = damage_vulnerabilities
//        self.damage_resistances = damage_resistances
//        self.damage_immunities = damage_immunities
//        self.condition_immunities = condition_immunities
//        self.senses = from.senses
//        self.languages  = from.languages
//        self.challenge_rating.value = from.challenge_rating.value
//        self.special_abilities = special_abilities
//        self.actions = actions
//        self.legendary_actions = legendary_actions
//        self.url = from.url
//        self.isFavorite = from.isFavorite
//
//    }
//
//
//    func setData(from: Monster){
//
//        let damage_vulnerabilities = List<String>()
//        for str in from.damage_vulnerabilities{
//            damage_vulnerabilities.append(str)
//        }
//
//        let damage_resistances = List<String>()
//        for str in from.damage_resistances{
//            damage_resistances.append(str)
//        }
//
//        let damage_immunities = List<String>()
//        for str in from.damage_immunities{
//            damage_immunities.append(str)
//        }
//
//        let condition_immunities = List<DBConditionImmunities>()
//        //        if from.condition_immunities != nil {
//        for str in from.condition_immunities{
//            condition_immunities.append(DBConditionImmunities(from: str))
//        }
//        //        }
//
//        let proficiencies = List<DBProficiencies>()
//        for str in from.proficiencies{
//            proficiencies.append(DBProficiencies(from: str))
//        }
//
//        let special_abilities = List<DBSpecialAbilities>()
//        if from.special_abilities != nil {
//            for str in from.special_abilities!{
//                special_abilities.append(DBSpecialAbilities(from: str))
//            }
//
//        }
//
//        let actions = List<DBActions>()
//        if from.actions != nil {
//            for str in from.actions!{
//                actions.append(DBActions(from: str))
//            }
//        }
//        let legendary_actions = List<DBActions>()
//        if from.legendary_actions != nil {
//            for str in from.legendary_actions!{
//                legendary_actions.append(DBActions(from: str))
//            }
//        }
//        self._id = from._id
//        self.index = from.index
//        self.name = from.name
//        self.size = from.size
//        self.type = from.type
//        self.subtype = from.subtype
//        self.alignment = from.alignment
//        self.armor_class = from.armor_class
//        self.hit_points = from.hit_points
//        self.hit_dice = from.hit_dice
//        //    let speed: Speed
//        self.strength = from.strength
//        self.dexterity = from.dexterity
//        self.constitution = from.constitution
//        self.intelligence = from.intelligence
//        self.wisdom = from.wisdom
//        self.charisma = from.charisma
//        self.proficiencies = proficiencies
//        self.damage_vulnerabilities = damage_vulnerabilities
//        self.damage_resistances = damage_resistances
//        self.damage_immunities = damage_immunities
//        self.condition_immunities = condition_immunities
//        self.senses = DBSenses(from: from.senses)
//        self.languages  = from.languages
//        self.challenge_rating.value = from.challenge_rating!
//        self.special_abilities = special_abilities
//        self.actions = actions
//        self.legendary_actions = legendary_actions
//        self.url = from.url
//
//    }
//
//
//
//    required init() {
//        //        super.init()
//        //        fatalError("init() has not been implemented")
//    }
//
//    //MARK:- DBMonster.toString()
//    func toString() -> String {
//        var res = ""
//        let name = "\(self.name.makeBold().addLineBreaker())"
//
//        let sz = "Size: \(self.size.addLineBreaker())"
//        let type = "Type: \(self.type.addLineBreaker())"
//        let hp = "Hit Points: \(String(self.hit_points).addLineBreaker())"
//        let ac = "Armor Class: \(String(self.armor_class).addLineBreaker())"
//
//        let str = "Str: \(String(self.strength).addLineBreaker())"
//        let dex = "Dex: \(String(self.dexterity).addLineBreaker())"
//        let con = "Con: \(String(self.constitution).addLineBreaker())"
//        let int = "Int: \(String(self.intelligence).addLineBreaker())"
//        let wis = "Wis: \(String(self.wisdom).addLineBreaker())"
//        let char = "Char: \(String(self.charisma).addLineBreaker())"
//
//        let proficiencies = self.proficiencies.toString()
//
//        let damage_vulnerabilities = self.damage_vulnerabilities.toString(type: .Vulnerabilities)
//        let damage_resistances = self.damage_resistances.toString(type: .Resistances)
//        let damage_immunities = self.damage_immunities.toString(type: .Immunities)
//        let senses = self.senses?.getString()
//        let languages = "Languages: \(self.languages)".addLineBreaker()
//        var challenge_rating = ""
//        if self.challenge_rating.value != nil{
//            challenge_rating.append("Challenge Rating: ".makeBold())
//            challenge_rating.append("\(String(describing: self.challenge_rating.value!))".addLineBreaker())
//        }
//        let special_abilities = self.special_abilities.toString()
//
//        let actions = self.actions.toString(type: .Actions)
//        let legendaryActions = self.legendary_actions.toString(type: .LegendaryActions)
//
//
//        res.append(name)
//        res.append(sz)
//        res.append(type)
//        res.append(hp)
//        res.append(ac)
//        res.append(str)
//        res.append(dex)
//        res.append(con)
//        res.append(int)
//        res.append(wis)
//        res.append(char)
//        res.append(proficiencies)
//        res.append(damage_vulnerabilities)
//        res.append(damage_resistances)
//        res.append(damage_immunities)
//        if senses != nil {
//            res.append(senses!)
//        }
//        res.append(languages)
//        res.append(challenge_rating)
//        res.append(special_abilities)
//        res.append(actions)
//        res.append(legendaryActions)
//
//        res.append(String(isFavorite))
//
//        return res
//
//    }
//
//    func getCellData() -> [String] {
//        var res: [String] = []
//        let name = "\(self.name)"
//        let index = "\(self.index)"
//        let hp = "HP: \(self.hit_points)"
//        let ac = "AC: \(self.armor_class)"
//
//        res.append(name)
//        res.append(index)
//        res.append(hp)
//        res.append(ac)
//
//        return res
//    }
//
//
//}
//
//
//class DBConditionImmunities: Object{
//    @objc dynamic var name: String = ""
//    @objc dynamic var url: String = ""
//
//    init(from: ConditionImmunities){
//        self.name = from.name
//        self.url = from.url
//    }
//
//    required init() {
//        super.init()
//        //        fatalError("init() has not been implemented")
//    }
//
//}


class DBActions: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    
    init(from: Actions){
        self.name = from.name
        self.desc = from.desc
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    func toString()->String{
        var res = ""
        res.append("Action: \(self.name)".makeBold().addLineBreaker())
        res.append("Description: \(self.desc)".addLineBreaker())
        return res
    }
    
}

//class DBSpecialAbilities: Object{
//    @objc dynamic var name: String = ""
//    @objc dynamic var desc: String = ""
//    var usage: DBUsage? = nil
//
//    init(from: SpecialAbilities){
//        self.name = from.name
//        self.desc = from.desc
//        if from.usage != nil{
//            self.usage = DBUsage(from: from.usage!)
//        }else {
//            self.usage = nil
//        }
//
//    }
//
//    required init() {
//        super.init()
//        //        fatalError("init() has not been implemented")
//    }
//
//
//    
//    func toString()->String{
//        var res = ""
//        res.append("Special Abilities: ".makeBold())
//        res.append("\(self.name)".addLineBreaker())
//        if self.usage != nil{
//            res.append("Usage: \(self.usage!.toString())".addLineBreaker())
//        }
//        res.append("Description:".makeBold().addLineBreaker())
//        res.append("\(self.desc)".addLineBreaker())
//        return res
//    }
//}

class DBSpeed: Object{
    @objc dynamic var walk: String? = nil
    @objc dynamic var fly: String? = nil
    @objc dynamic var swim: String? = nil
    init(from: Speed){
        self.walk = from.walk
        self.fly = from.fly
        self.swim = from.swim
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    
}

//class DBProficiencies: Object{
//    @objc dynamic var name: String = ""
//    @objc dynamic var url: String = ""
//    @objc dynamic var value: Int = 0
//    init(from: Proficiencies){
//        self.name = from.name
//        self.url = from.url
//        self.value = from.value
//    }
//
//    required init() {
//        super.init()
//        //        fatalError("init() has not been implemented")
//    }
//}

class DBSenses: Object {
    @objc dynamic var blindsight: String? = nil
    @objc dynamic var darkvision: String? = nil
    let passive_perception = RealmOptional<Int>()
    init(from: Senses){
        self.blindsight = from.blindsight
        self.darkvision = from.darkvision
        self.passive_perception.value = from.passive_perception
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    
    func getString()->String{
        
        var res = ""
        if self.blindsight != nil{
            res.append("Blindsight: ".makeBold())
            res.append("\(String(describing: self.blindsight!))".addLineBreaker())
        }
        if self.darkvision != nil{
            res.append("Darkvision: ".makeBold())
            res.append("\(String(describing: self.darkvision!))".addLineBreaker())
        }
        if self.passive_perception.value != nil{
            res.append("Passive Perseption: ".makeBold())
            res.append("\(String(describing: self.passive_perception.value!))".addLineBreaker())
        }
        
        
        return res
    }
    
    
}

class DBUsage: Object, MyDBObject  {
    var isFavorite: Bool = false
    
    func setData(from: Usage) {
        self.type = from.type
        self.times.value = from.times
    }
    
    
    var name: String = ""
    
    @objc dynamic var type: String = ""
    var times = RealmOptional<Int>()
    
    init(from: Usage){
        self.type = from.type
        self.times.value = from.times
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    func toString() -> String {
        var res = ""
        res.append("Type: \(self.type)")
        if times.value != nil{
            res.append("Times: \(self.times)")
        }
        return res
    }
    
    func getCellData() -> [String] {
        return []
    }
}

class DBNamedApiResource: Object{
    @objc dynamic var index: String?
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    
    init(from: NamedApiResource){
        self.index = from.index
        self.name = from.name
        self.url = from.url
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
}

class DBCommonReq: Object{
    @objc dynamic var count: Int = 0
    var results = List<DBNamedApiResource>()
    
    init(from: CommonReq){
        self.count = from.count
        let results = List<DBNamedApiResource>()
        for str in from.results{
            results.append(DBNamedApiResource(from: str))
        }
    }
    
    required init() {
        super.init()
    }
}


class NewDBMonster: Object, MyDBObject{
    
    @objc dynamic var slug: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var subtype: String? = nil
    @objc dynamic var group: String? = nil
    @objc dynamic var alignment: String = ""
    @objc dynamic var armor_class: Int = 0
    @objc dynamic var armor_desc: String? = nil
    @objc dynamic var hit_points: Int = 0
    @objc dynamic var hit_dice: String = ""
    @objc dynamic var speed: NewDBSpeed? = nil
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
    @objc dynamic var condition_immunities: String? = nil
    @objc dynamic var senses: String? = nil
    @objc dynamic var languages : String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var challenge_rating : String? = nil
    
    var special_abilities = List<NewDBActions>()
    var actions = List<NewDBActions>()
    var legendary_actions = List<NewDBActions>()
    
    @objc dynamic var legendary_desc: String? = nil
    var spell_list = List<String>()
    @objc dynamic var img_main: String? = nil
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    init (from: NewMonster){
        
        let special_abilities = List<NewDBActions>()
        var tmp = NewDBMonster.castAnyObjectToActions(action: from.special_abilities)
        if tmp.count > 0{
            tmp.forEach{ action in
                special_abilities.append(NewDBActions(from: action))
            }
        }
        
        let actions = List<NewDBActions>()
        tmp =  NewDBMonster.castAnyObjectToActions(action: from.actions)
        if tmp.count > 0{
            tmp.forEach{ action in
                special_abilities.append(NewDBActions(from: action))
            }
        }
        
        let legendary_actions = List<NewDBActions>()
        tmp =  NewDBMonster.castAnyObjectToActions(action: from.legendary_actions)
        if tmp.count > 0{
            tmp.forEach{ action in
                special_abilities.append(NewDBActions(from: action))
            }
        }
    
        self.slug = from.slug
        self.name = from.name
        self.size = from.size
        self.type = from.type
        self.subtype = from.subtype
        self.alignment = from.alignment
        self.armor_class = from.armor_class
        self.hit_points = from.hit_points
        self.hit_dice = from.hit_dice
        self.speed = NewDBSpeed(from: from.speed)
        
        self.strength = from.strength
        self.dexterity = from.dexterity
        self.constitution = from.constitution
        self.intelligence = from.intelligence
        self.wisdom = from.wisdom
        self.charisma = from.charisma
        
        self.strength_save.value = from.strength_save
        
        
        self.dexterity_save.value = from.dexterity_save
        self.constitution_save.value = from.constitution_save
        self.intelligence_save.value = from.intelligence_save
        self.wisdom_save.value = from.wisdom_save
        self.charisma_save.value = from.charisma_save
        self.perception.value = from.perception
        
        
        self.damage_vulnerabilities = from.damage_vulnerabilities
        self.damage_resistances = from.damage_resistances
        self.damage_immunities = from.damage_immunities
        self.condition_immunities = from.condition_immunities
        self.senses = from.senses
        
        self.languages  = from.languages
        self.challenge_rating = from.challenge_rating
        self.special_abilities = special_abilities
        self.actions = actions
        self.legendary_actions = legendary_actions
        
        
        self.img_main = from.img_main
        
        
    }
    
    init (from: NewDBMonster){
        
        let damage_vulnerabilities = from.damage_vulnerabilities
        let damage_resistances = from.damage_resistances
        let damage_immunities = from.damage_immunities
        let condition_immunities = from.condition_immunities
        let special_abilities = from.special_abilities
        let actions = from.actions
        let legendary_actions = from.legendary_actions
        
        self.slug = from.slug
        
        self.name = from.name
        self.size = from.size
        self.type = from.type
        self.subtype = from.subtype
        self.alignment = from.alignment
        self.armor_class = from.armor_class
        self.hit_points = from.hit_points
        self.hit_dice = from.hit_dice
        self.speed = from.speed
        self.strength = from.strength
        self.dexterity = from.dexterity
        self.constitution = from.constitution
        self.intelligence = from.intelligence
        
        self.dexterity_save = from.dexterity_save
        self.constitution_save = from.constitution_save
        self.intelligence_save = from.intelligence_save
        self.wisdom_save = from.wisdom_save
        self.charisma_save = from.charisma_save
        self.perception = from.perception
        
        self.wisdom = from.wisdom
        self.charisma = from.charisma
        self.damage_vulnerabilities = damage_vulnerabilities
        self.damage_resistances = damage_resistances
        self.damage_immunities = damage_immunities
        self.condition_immunities = condition_immunities
        self.senses = from.senses
        self.languages  = from.languages
        self.challenge_rating = from.challenge_rating
        self.special_abilities = special_abilities
        self.actions = actions
        self.legendary_actions = legendary_actions
        
        self.img_main = from.img_main
        self.isFavorite = from.isFavorite
        
    }
    
    
    func setData(from: NewMonster){
        
        let special_abilities = List<NewDBActions>()
        var tmp =  NewDBMonster.castAnyObjectToActions(action: from.special_abilities)
        if tmp.count > 0{
            tmp.forEach{ action in
                special_abilities.append(NewDBActions(from: action))
            }
        }
        
        let actions = List<NewDBActions>()
        tmp =  NewDBMonster.castAnyObjectToActions(action: from.actions)
        if tmp.count > 0{
            tmp.forEach{ action in
                special_abilities.append(NewDBActions(from: action))
            }
        }
        
        let legendary_actions = List<NewDBActions>()
        tmp =  NewDBMonster.castAnyObjectToActions(action: from.legendary_actions)
        if tmp.count > 0{
            tmp.forEach{ action in
                special_abilities.append(NewDBActions(from: action))
            }
        }
        
        self.slug = from.slug
        self.name = from.name
        self.size = from.size
        self.type = from.type
        self.subtype = from.subtype
        self.alignment = from.alignment
        self.armor_class = from.armor_class
        self.hit_points = from.hit_points
        self.hit_dice = from.hit_dice
        self.speed = NewDBSpeed(from: from.speed)
        
        self.strength = from.strength
        self.dexterity = from.dexterity
        self.constitution = from.constitution
        self.intelligence = from.intelligence
        self.wisdom = from.wisdom
        self.charisma = from.charisma
        self.dexterity_save.value = from.dexterity_save
        self.constitution_save.value = from.constitution_save
        self.intelligence_save.value = from.intelligence_save
        self.wisdom_save.value = from.wisdom_save
        self.charisma_save.value = from.charisma_save
        self.perception.value = from.perception
        
        self.damage_vulnerabilities = from.damage_vulnerabilities
        self.damage_resistances = from.damage_resistances
        self.damage_immunities = from.damage_immunities
        self.condition_immunities = from.condition_immunities
        self.senses = from.senses
        
        self.languages  = from.languages
        self.challenge_rating = from.challenge_rating
        self.special_abilities = special_abilities
        self.actions = actions
        self.legendary_actions = legendary_actions
    
        self.img_main = from.img_main
    }
    
    
    required init() {

    }
    
    //MARK:- DBMonster.toString()
    func toString() -> String {
        var res = ""
        let name = "\(self.name.makeBold().addLineBreaker())"
        
        let sz = "Size: \(self.size.addLineBreaker())"
        let type = "Type: \(self.type.addLineBreaker())"
        let hp = "Hit Points: \(String(self.hit_points).addLineBreaker())"
        let ac = "Armor Class: \(String(self.armor_class).addLineBreaker())"
        
        let str = "Str: \(String(self.strength).addLineBreaker())"
        let dex = "Dex: \(String(self.dexterity).addLineBreaker())"
        let con = "Con: \(String(self.constitution).addLineBreaker())"
        let int = "Int: \(String(self.intelligence).addLineBreaker())"
        let wis = "Wis: \(String(self.wisdom).addLineBreaker())"
        let char = "Char: \(String(self.charisma).addLineBreaker())"
        
        let lb = "".addLineBreaker()

        let strSave = "Str Save: \(String(self.strength_save.value ?? 0).addLineBreaker())"
        let dexSave = "Dex Save: \(String(self.dexterity_save.value ?? 0).addLineBreaker())"
        let conSave = "Con Save: \(String(self.constitution_save.value ?? 0).addLineBreaker())"
        let intSave = "Int Save: \(String(self.intelligence_save.value ?? 0).addLineBreaker())"
        let wisSave = "Wis Save: \(String(self.wisdom_save.value ?? 0).addLineBreaker())"
        let charSave = "Char Save: \(String(self.charisma_save.value ?? 0).addLineBreaker())"
        
        let perseption = "Perseprion: \(String(self.perception.value ?? 0).addLineBreaker())"

        let damage_vulnerabilities = "Damage Vulnerabilities: \(self.damage_vulnerabilities.addLineBreaker())"
        let damage_resistances = "Damage Resistances: \(self.damage_resistances.addLineBreaker())"
        let damage_immunities = "Damage Immunities: \(self.damage_immunities.addLineBreaker())"
        let senses = "Senses \((self.senses ?? "-").addLineBreaker())"
        let languages = "Languages: \(self.languages)".addLineBreaker()
        var challenge_rating = ""
        if self.challenge_rating != nil{
            challenge_rating.append("Challenge Rating: ".makeBold())
            challenge_rating.append("\(String(describing: self.challenge_rating!))".addLineBreaker())
        }
        
        
        let special_abilities = self.special_abilities.toString(type: .SpecialAbilities)
        let actions = self.actions.toString(type: .Actions)
        let legendaryActions = self.legendary_actions.toString(type: .LegendaryActions)
        
        
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
        res.append(lb)
        res.append(special_abilities)
        res.append(actions)
        res.append(lb)
        res.append(legendaryActions)
        
//        res.append(String(isFavorite))
        
        return res
        
    }
    
    func getCellData() -> [String] {
        var res: [String] = []
        let name = "\(self.name)"
//        let index = "\(self.index)"
        let hp = "❤️:\(self.hit_points) 🛡:\(self.armor_class)"
        let ac = "AC: \(self.armor_class)"
        
        res.append(name)
//        res.append(index)
        res.append(hp)
        res.append(ac)
        
        return res
    }
    
    
    
    
    
    static func castAnyObjectToActions(action : JSONAny)->[Actions]{
        var tmp: [Actions]?
        tmp = action.value as? [Actions]
        if tmp != nil{
            return tmp!
        }
        return []
    }
    
}



class NewDBSpeed: Object{
    var walk = RealmOptional<Int>()
    var fly = RealmOptional<Int>()
    var swim = RealmOptional<Int>()
    var climb =  RealmOptional<Int>()
    
    init(from: NewSpeed){
        self.walk.value = from.walk
        self.fly.value = from.fly
        self.swim.value = from.swim
        self.climb.value = from.climb
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    func toString()->String{
        var res = ""
        if  self.walk.value != nil ||
            self.fly.value != nil ||
            self.swim.value != nil ||
            self.climb.value != nil{
            
            res.append("Speed: ".makeBold().addLineBreaker())
            if self.walk.value != nil{
                res.append("Walk: \(self.walk.value!)".addLineBreaker())
            }
            if self.fly.value != nil{
                res.append("Walk: \(self.fly.value!)".addLineBreaker())
            }
            if self.swim.value != nil{
                res.append("Walk: \(self.swim.value!)".addLineBreaker())
            }
            if self.climb.value != nil{
                res.append("Walk: \(self.climb.value!)".addLineBreaker())
            }
        }
        return res
    }
}

class NewDBActions: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    var attack_bonus = RealmOptional<Int>()
    @objc dynamic var damage_dice: String?
    var damage_bonus = RealmOptional<Int>()
    
    init(from: Actions){
        self.name = from.name
        self.desc = from.desc
        self.attack_bonus.value = from.attack_bonus
        self.damage_bonus.value = from.damage_bonus
        self.damage_dice = from.damage_dice
    }
    
    required init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    func toString()->String{
        var res = ""
        res.append("Action: \(self.name)".makeBold().addLineBreaker())
        res.append("Description: \(self.desc)".addLineBreaker())
        if self.attack_bonus.value != nil{
            res.append("Attack Bonus: \(self.attack_bonus.value!)".addLineBreaker())
        }
        if self.damage_bonus.value != nil{
            res.append("DMG bonus: \(self.damage_bonus.value!)".addLineBreaker())
        }
        if self.damage_dice != nil{
            res.append("Damage Dice: \(self.damage_dice!)".addLineBreaker())
        }
        return res
    }
}

