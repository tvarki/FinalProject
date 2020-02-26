//
//  SwiftClassFactory.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class SwiftClassFactory{
    init(){
        
    }
    
    static func createDBMonsterClass(tmp: Any) -> DBMonster{
        let any = tmp as? Monster
        guard any != nil else{return DBMonster()}
        let tmp = DBMonster(from: any!)
        return tmp
    }

    static func getDBMonsterClass()->DBMonster.Type{
        return DBMonster.self
    }
    
    static func getMonsterClass()->Monster.Type{
        return Monster.self
    }
    
    static func getCommonRequestClass()->CommonReq.Type{
        return CommonReq.self
    }
    
}


//enum CreateDBSwiftClass {
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
//}
//
//class SwiftClassFactory{
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
//}
