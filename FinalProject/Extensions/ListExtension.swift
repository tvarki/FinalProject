//
//  ListExtension.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

//extension List where Element == DBProficiencies{
//    func toString()->String{
//        guard self.count != 0 else{return ""}
//        var res = "Profiencies".makeBold().addLineBreaker()
//        for tmp in self{
//            res.append("\(tmp.name) = \(tmp.value)".addLineBreaker())
//        }
//        return res
//    }
//}

extension List where Element == String{
    func toString(type: typeDamageListString)->String{
        guard self.count != 0 else{return ""}
        
        var res = ""
        switch type {
        case .Immunities:
            res.append("Immunities: ".makeBold().addLineBreaker())
        case .Resistances:
            res.append("Resistances: ".makeBold().addLineBreaker())
        case .Vulnerabilities:
            res.append("Vulnerabilities: ".makeBold().addLineBreaker())
        }
        for tmp in self{
            res.append(tmp.addLineBreaker())
        }
        return res
    }
}

extension List where Element == DBActions{
    func toString(type: actionsType)->String{
        guard self.count != 0 else{return ""}
        
        var res = ""
        switch type {
        case .Actions:
            res.append("Actions: ".makeBold().addLineBreaker())
        case .LegendaryActions:
            res.append("LegendaryActions: ".makeBold().addLineBreaker())
        }
        for tmp in self{
            res.append(tmp.toString())
        }
        return res
    }
}
//
//extension List where Element == DBSpecialAbilities{
//    func toString()->String{
//        guard self.count != 0 else{return ""}
//        var res = ""
//        for tmp in self{
//            res.append(tmp.toString().addLineBreaker())
//        }
//        return res
//    }
//}

extension List where Element == NewDBActions{
    func toString(type: newActionsType)->String{
           guard self.count != 0 else{return ""}
           
           var res = ""
           switch type {
           case .Actions:
               res.append("Actions: ".makeBold().addLineBreaker())
           case .LegendaryActions:
               res.append("LegendaryActions: ".makeBold().addLineBreaker())
            case .SpecialAbilities:
            res.append("Special Abilities: ".makeBold().addLineBreaker())

            }

           for tmp in self{
               res.append(tmp.toString())
           }
           return res
       }
}


enum typeDamageListString{
    case Vulnerabilities
    case Resistances
    case Immunities
}

enum actionsType{
    case Actions
    case LegendaryActions
}

enum newActionsType{
    case Actions
    case LegendaryActions
    case SpecialAbilities
}
