//
//  SwiftClassFactory.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class SwiftClassFactory {
    init() {}

    // MARK: - Monster

//    static func createNewDBMonsterClass(tmp: Any) -> NewDBMonster {
//        let any = tmp as? MonsterDTO
//        guard any != nil else { return NewDBMonster() }
//        let tmp = NewDBMonster(from: any!)
//        return tmp
//    }

    static func getNewDBMonsterClass() -> NewDBMonster.Type {
        return NewDBMonster.self
    }

    static func getNewMonsterClass() -> MonsterDTO.Type {
        return MonsterDTO.self
    }

    static func getMonsterItemClass() -> MonsterItem.Type {
        return MonsterItem.self
    }

    // MARK: - MagicItem

    static func getNewDBMagicItemClass() -> NewDBMagicItem.Type {
        return NewDBMagicItem.self
    }

    static func getMagicItemDTOClass() -> MagicItemDTO.Type {
        return MagicItemDTO.self
    }

    static func getMagicItemClass() -> MagicItem.Type {
        return MagicItem.self
    }

    static func getNewCommonMonsterRequestClass() -> CommonMonsterReqDTO.Type {
        return CommonMonsterReqDTO.self
    }

    static func getNewCommonMagicItemRequestClass() -> CommonMagicItemReqDTO.Type {
        return CommonMagicItemReqDTO.self
    }
}

// enum CreateDBSwiftClass {
//
//    case Monster
//    case Usage
//    func returnClass(data: Any) -> MyDBObject{
//        switch self{
//        case .Monster:
//            let any = data as? Monster
//            let tmp = DBMonster(from: any!)
//            return tmp
//        case .Usage:
//            let tmp = DBUsage()
//            return tmp
//        }
//    }
// }
//
// class SwiftClassFactory{
//    let data : CreateDBSwiftClass
//
//    init(_ data: CreateDBSwiftClass){
//        self.data = data
//    }
//    func result(tmp: Any) -> MyDBObject{
//        switch data {
//        case .Monster: return CreateDBSwiftClass.Monster.returnClass(data: tmp)
//        case .Usage: return CreateDBSwiftClass.Usage.returnClass(data: tmp)
//        }
//    }
// }
