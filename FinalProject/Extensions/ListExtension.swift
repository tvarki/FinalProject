//
//  ListExtension.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

// extension List where Element == DBProficiencies{
//    func toString()->String{
//        guard self.count != 0 else{return ""}
//        var res = "Profiencies".makeBold().addLineBreaker()
//        for tmp in self{
//            res.append("\(tmp.name) = \(tmp.value)".addLineBreaker())
//        }
//        return res
//    }
// }

extension List where Element == String {
    func toString(type: TypeDamageListString) -> String {
        guard count != 0 else { return "" }

        var res = ""
        switch type {
        case .Immunities:
            res.append("Immunities: ".makeBold().addLineBreaker())
        case .Resistances:
            res.append("Resistances: ".makeBold().addLineBreaker())
        case .Vulnerabilities:
            res.append("Vulnerabilities: ".makeBold().addLineBreaker())
        }
        for tmp in self {
            res.append(tmp.addLineBreaker())
        }
        return res
    }
}

//
// extension List where Element == DBSpecialAbilities{
//    func toString()->String{
//        guard self.count != 0 else{return ""}
//        var res = ""
//        for tmp in self{
//            res.append(tmp.toString().addLineBreaker())
//        }
//        return res
//    }
// }

extension List where Element == NewDBActions {
    func toString(type: ActionsType) -> String {
        guard count != 0 else { return "" }

        var res = ""
        switch type {
        case .Actions:
            res.append("Actions: ".makeBold().addLineBreaker())
        case .LegendaryActions:
            res.append("LegendaryActions: ".makeBold().addLineBreaker())
        case .SpecialAbilities:
            res.append("Special Abilities: ".makeBold().addLineBreaker())
        }

        for tmp in self {
            res.append(tmp.toString())
        }
        return res
    }
}

extension Array where Element == Actions {
    func toString(type: ActionsType) -> String {
        guard count != 0 else { return "" }

        var res = ""
        res.append("".addLineBreaker())
        switch type {
        case .Actions:
            res.append("Actions: ".makeBold().addLineBreaker())
        case .LegendaryActions:
            res.append("LegendaryActions: ".makeBold().addLineBreaker())
        case .SpecialAbilities:
            res.append("Special Abilities: ".makeBold().addLineBreaker())
        }

        for tmp in self {
            res.append(tmp.toString(type: type))
        }
        return res
    }
}

enum TypeDamageListString {
    case Vulnerabilities
    case Resistances
    case Immunities
}

enum ActionsType {
    case Actions
    case LegendaryActions
    case SpecialAbilities
}
