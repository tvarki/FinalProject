//
//  MagicItemService.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

final class MagicItemService {
    let requestService = NetRequestsService()
    private var coreMagicItemModel = CoreMagicItemModel()

    init() {}

    func start(completion: @escaping ([MagicItem]) -> Void, fail: @escaping (String) -> Void) {
        if !updateFromDB(completion: completion) {
            updatePostsFromInternet(completion: completion, fail: fail)
        }
    }

    func updatePostsFromInternet(endPoint: String = "magicitems/", completion: @escaping ([MagicItem]) -> Void, fail: @escaping (String) -> Void) {
        downloadMagicItemPosts(endPoint: endPoint, topCompletion: completion, failure: fail)
    }

    func dawnloadNext(completion: @escaping ([MagicItem]) -> Void, fail: @escaping (String) -> Void) {
        let next = UDService.getFromUserDefaults(key: "NextMagicItemArray")
        guard next != nil, next != "" else { return }
        updatePostsFromInternet(endPoint: next!, completion: completion, fail: fail)
    }

    @discardableResult func updateFromDB(completion: @escaping ([MagicItem]) -> Void) -> Bool {
        let tmp = coreMagicItemModel.getAllMagicItem()
        if tmp.count > 0 {
            DispatchQueue.main.async {
                completion(tmp)
            }
            return true
        }
        return false
    }

    func updateMagicItemRarity(magicItemArray: [MagicItem]) -> [String] {
        var monsterType: [String] = []
        magicItemArray.forEach { mstr in
            if !monsterType.contains(mstr.type.lowercased().firstUppercased) {
                monsterType.append(mstr.type.lowercased().firstUppercased)
            }
        }
        monsterType.sort()
        return monsterType
    }

    func setFaforite(item: MagicItem) {
        coreMagicItemModel.changePostInDB(item: item)
    }

    func getAllMonsterTypes(magicItemArray: [MagicItem]) -> [String] {
        return updateMagicItemRarity(magicItemArray: magicItemArray)
    }

    func deleteAll() {
        coreMagicItemModel.deleteAllDB()
    }

    func downloadMagicItemPosts(endPoint: String, topCompletion: @escaping ([MagicItem]) -> Void, failure: @escaping (String) -> Void) {
        autoreleasepool {
            self.requestService.sendGetReqest(
                type: SwiftClassFactory.getNewCommonMagicItemRequestClass(),
                endPoint: endPoint,
                completion: { res in

                    print(res.results)

                    UDService.writeToUserDefaults(str: res.next ?? "", key: "NextMagicItemArray")
                    self.coreMagicItemModel.addPostToDB(monster: res.results)
                    self.updateFromDB(completion: topCompletion)
                },
                failure: { error in
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            )
        }
    }
}
