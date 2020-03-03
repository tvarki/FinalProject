//
//  CoreMagicItemModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class CoreMagicItemModel {
    let corePostService = CorePostService()

    func getAllMagicItem() -> [MagicItem] {
        let type = SwiftClassFactory.getNewDBMagicItemClass()
        let list = corePostService.getAllPosts(ofType: type)
        return createMonsterArrayFromDBArray(dbArray: list)
    }

    func getAllFavoritedPosts() -> [MagicItem] {
        let type = SwiftClassFactory.getNewDBMagicItemClass()
        let favoriteArray = corePostService.getAllFAvoritedPosts(ofType: type)
        return createMonsterArrayFromDBArray(dbArray: favoriteArray)
    }

    func addPostToDB(monster: [MagicItemDTO]) {
        var myObject: [NewDBMagicItem] = []
        monster.forEach { mstr in
            myObject.append(NewDBMagicItem(from: mstr))
        }
        corePostService.addPostToDB(post: myObject)
    }

    func changePostInDB(item: MagicItem) {
        let myObject = NewDBMagicItem(from: item)
        corePostService.changePostInDB(object: myObject, type: NewDBMagicItem.self)
    }

    func createMonsterArrayFromDBArray(dbArray: [NewDBMagicItem]) -> [MagicItem] {
        var resultList: [MagicItem] = []
        dbArray.forEach { itm in
            resultList.append(MagicItem(from: itm))
        }
        return resultList
    }

    func deleteAllDB() {
        corePostService.deleteAllDB()
    }
}
