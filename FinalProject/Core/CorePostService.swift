//
//  Posts.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 26.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

class CorePostService {
    let dbManager = DBManager()
    private var count = 0
    let batchSize = 2
    var timer = Timer()

    init() {}

    // MARK: - get all data from DB

    func getAllPosts<P: Object>(ofType: P.Type) -> [P] {
        guard let tmp = dbManager.getDataFromDB(type: ofType)
        else { return [] }
        return Array(tmp)
    }

    func getAllFAvoritedPosts<P>(ofType: P.Type) -> [P] where P: MyDBObject {
        guard let tmp = dbManager.getFavoriteDataFromDB(type: ofType)
        else { return [] }
        return Array(tmp)
    }

    // MARK: - add data to DB

    func addPostToDB<P>(post: [P]) where P: MyDBObject {
        dbManager.addData(object: post)
    }

    // MARK: - change post in DB

    func changePostInDB<P>(object: P, type: P.Type) where P: MyDBObject {
        dbManager.changeData(object: object, type: type)
    }

    // MARK: - get post by id

    func getPost<P: Object>(index: String, type: P.Type) -> P? {
        let tmp = dbManager.getItem(index: index, type: type)
        return tmp
    }

    // MARK: - delete objewct from db

    func deleteFromDB<P: Object>(object: P) {
        count -= 1
        dbManager.deleteFromDb(object: object)
    }

    // MARK: - delete all data from DB

    func deleteAllDB() {
        count = 0
        dbManager.deleteAllDatabase()
    }

    func getItemsCount<P: Object>(type: P.Type) -> Int {
        return dbManager.getCount(type: type)
    }
}
