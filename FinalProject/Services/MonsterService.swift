//
//  PostModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

protocol ModelUpdating: AnyObject {
    func updateModel()
    func showError(error: String)
}

final class MonsterService {
    let requestService = NetRequestsService()
    private var universalItemModel = UniversalItemModel()

    init() {}

    func start(completion: @escaping ([MonsterItem]) -> Void, fail: @escaping (String) -> Void) {
        if updateFromDB(completion: completion) {
            updatePostsFromInternet(completion: completion, fail: fail)
        }
    }

    func updatePostsFromInternet(endPoint: String = "monsters/", completion: @escaping ([MonsterItem]) -> Void, fail: @escaping (String) -> Void) {
        downloadMonsterPosts(endPoint: endPoint, topCompletion: completion, failure: fail)
    }

    func dawnloadNext(completion: @escaping ([MonsterItem]) -> Void, fail: @escaping (String) -> Void) {
        let next = UDService.getFromUserDefaults(key: "NextArray")
        guard next != nil, next != "" else { return }
        updatePostsFromInternet(endPoint: next!, completion: completion, fail: fail)
    }

    @discardableResult func updateFromDB(completion: @escaping ([MonsterItem]) -> Void) -> Bool {
        let tmp = universalItemModel.getAllMonster()
        if tmp.count > 0 {
            DispatchQueue.main.async {
                completion(tmp)
            }
            return true
        }
        return false
    }

    func updateMonsterTypes(monsterArray: [MonsterItem]) -> [String] {
        var monsterType: [String] = []
        monsterArray.forEach { mstr in
            if !monsterType.contains(mstr.type.lowercased().firstUppercased) {
                monsterType.append(mstr.type.lowercased().firstUppercased)
            }
        }
        monsterType.sort()
        return monsterType
    }

    func setFaforite(item: MonsterItem) {
        universalItemModel.changePostInDB(monster: item)
    }

    func getAllMonsterTypes(monsterArray: [MonsterItem]) -> [String] {
        return updateMonsterTypes(monsterArray: monsterArray)
    }

    func downloadPost(completion: @escaping ([MonsterItem]) -> Void, failure: @escaping (String) -> Void) {
        downloadMonsterPosts(endPoint: "monsters/", topCompletion: { array in
            DispatchQueue.main.async {
                completion(array)
            }
        }, failure: { error in
            DispatchQueue.main.async {
                failure(error)
            }
        })
    }

    func deleteAll() {
        universalItemModel.deleteAllDB()
    }

    func downloadMonsterPosts(endPoint: String, topCompletion: @escaping ([MonsterItem]) -> Void, failure: @escaping (String) -> Void) {
        autoreleasepool {
            self.requestService.sendGetReqest(
                type: SwiftClassFactory.getNewCommonRequestClass(),
                endPoint: endPoint,
                completion: { res in
                    UDService.writeToUserDefaults(str: res.next ?? "", key: "NextArray")
                    self.universalItemModel.addPostToDB(monster: res.results)
                    self.updateFromDB(completion: topCompletion)
                },
                failure: { error in
                    failure(error)
                }
            )
        }
    }
}
