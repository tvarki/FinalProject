//
//  UniversalItemModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class UniversalItemModel {
    let corePostService = CorePostService()

    func getAllMonster() -> [MonsterItem] {
        let type = SwiftClassFactory.getNewDBMonsterClass()
        let list = corePostService.getAllPosts(ofType: type)
        return createMonsterArrayFromDBArray(dbArray: list)
    }

    func getAllFavoritedPosts() -> [MonsterItem] {
        let type = SwiftClassFactory.getNewDBMonsterClass()
        let favoriteArray = corePostService.getAllFAvoritedPosts(ofType: type)
        return createMonsterArrayFromDBArray(dbArray: favoriteArray)
    }

    func addPostToDB(monster: [DTOMonster]) {
        var myObject: [NewDBMonster] = []
        monster.forEach { mstr in
            myObject.append(NewDBMonster(from: mstr))
        }
        corePostService.addPostToDB(post: myObject)
    }

    func changePostInDB(monster: MonsterItem) {
        let myObject = NewDBMonster(from: monster)
        corePostService.changePostInDB(object: myObject, type: NewDBMonster.self)
    }

    func createMonsterArrayFromDBArray(dbArray: [NewDBMonster]) -> [MonsterItem] {
        var resultList: [MonsterItem] = []
        dbArray.forEach { mstr in
            resultList.append(MonsterItem(from: mstr))
        }
        return resultList
    }

    func deleteAllDB() {
        corePostService.deleteAllDB()
    }
}
