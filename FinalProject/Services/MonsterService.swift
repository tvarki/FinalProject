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

    private var isFavorite = false

    private var monsterArray: [MonsterItem] = []
    private var searchMonsterArray: [MonsterItem] = []

    private var favoriteArray: [MonsterItem] = []
    private var searchFavoriteArray: [MonsterItem] = []

    weak var delegate: ModelUpdating?
    private var monsterType: [String] = []

    private var searchString: String = ""
    private var searchFilterArray: [String] = []

    init() {
        updateFromDB()
        if monsterArray.count == 0 {
            updatePostsFromInternet()
        }
    }

    func getFavoriteList() {
        //        print("Function: \(#function), line: \(#line)")
        favoriteArray.removeAll()
        for mstr in monsterArray where mstr.isFavorite {
            favoriteArray.append(mstr)
        }
        searchChanged(str: searchString, filterList: searchFilterArray)
    }

    func switchToFavorite(isTrue: Bool) {
        //        print("Function: \(#function), line: \(#line)")
        isFavorite = isTrue
        getFavoriteList()
    }

    func updatePostsFromInternet(endPoint: String = "monsters/") {
        downloadMonsterPosts(endPoint: endPoint, topCompletion: {
            self.updateFromDB()
            self.delegate?.updateModel()
        }, failure: { error in
            self.delegate?.showError(error: error)
        })
    }

    func deleteFromFavorite(index: Int) {
        //        print("Function: \(#function), line: \(#line)")

        let monster = searchFavoriteArray[index]
        guard let i = favoriteArray.firstIndex(where: { $0.name == monster.name }) else { return }
        searchFavoriteArray.remove(at: index)
        favoriteArray.remove(at: i)
        //        searchChanged(str: searchString, filterList: searchFilterArray)
    }

    func getGlobalCount() -> Int {
        return monsterArray.count
    }

    func getCount() -> Int {
        if !isFavorite {
            return searchMonsterArray.count
        } else {
            return searchFavoriteArray.count
        }
    }

    func getPost(index: Int) -> MonsterItem {
        //        print("\(index) + \(searchMonsterArray.count)")
        if !isFavorite {
            //            print("\(index) \(searchMonsterArray.count)")
            return searchMonsterArray[index]
        } else {
            return searchFavoriteArray[index]
        }
    }

    func getPost(name: String) -> MonsterItem? {
        //        print("Function: \(#function), line: \(#line)")
        for monster in searchMonsterArray where monster.name == name {
            return monster
        }
        return nil
    }

    func getName(of index: Int) -> String {
        var name: String
        if !isFavorite {
            name = searchMonsterArray[index].getName()
        } else {
            name = searchFavoriteArray[index].getName()
        }
        return name
    }

    func getDetail(of index: Int) -> String {
        var detail: String
        if !isFavorite {
            detail = searchMonsterArray[index].getDetail()
        } else {
            detail = searchFavoriteArray[index].getDetail()
        }
        return detail
    }

    func dawnloadNext() {
        //        print("Function: \(#function), line: \(#line)")
        let next = UDService.getFromUserDefaults(key: "NextArray")
        guard next != nil, next != "" else { return }
        updatePostsFromInternet(endPoint: next!)
    }

    func clearMonstersArray() {
        monsterArray.removeAll()
    }

    func updateFromDB() {
        monsterArray = universalItemModel.getAllMonster()
        searchMonsterArray = monsterArray
        //        searchChanged(str: searchString, filterList: searchFilterArray)
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

    func setFaforite(forIndex: Int, value: Bool) {
        //        print("Function: \(#function), line: \(#line)")
        let object: MonsterItem
        if !isFavorite {
            object = monsterArray[forIndex]
        } else { object = favoriteArray[forIndex] }
        object.isFavorite = value
        universalItemModel.changePostInDB(monster: object)
    }

    func getAllPosts() -> [MonsterItem] {
        //        print("Function: \(#function), line: \(#line)")
        if !isFavorite {
            return monsterArray
        } else { return favoriteArray }
    }

    func getAllMonsterTypes() -> [String] {
        return updateMonsterTypes(monsterArray: monsterArray)
    }

    func fillSearchArray(str: String,
                         filterList: [String],
                         allMonsterArray: [MonsterItem],
                         array: inout [MonsterItem]) {
        var tmpArray: [MonsterItem] = []
        allMonsterArray.forEach { monster in
            if monster.name.lowercased().contains(str.lowercased()) || str == "" {
                if filterList.contains(monster.type.lowercased().firstUppercased) || filterList.count == 0 {
                    tmpArray.append(monster)
                }
            }
        }
        array = tmpArray
    }

    func searchChanged(str: String, filterList: [String]) {
        //        print("Function: \(#function), line: \(#line) monsterArray.count \(monsterArray.count)")
        if !isFavorite {
            fillSearchArray(str: str, filterList: filterList, allMonsterArray: monsterArray, array: &searchMonsterArray)

        } else {
            fillSearchArray(str: str, filterList: filterList, allMonsterArray: favoriteArray, array: &searchFavoriteArray)
        }
    }

    func downloadPost() {
        //        print("Function: \(#function), line: \(#line)")
        downloadMonsterPosts(endPoint: "monsters/", topCompletion: {
            self.delegate?.updateModel()
        }, failure: { error in
            self.delegate?.showError(error: error)
        })
    }

    func deleteAll() {
        monsterArray.removeAll()
        searchMonsterArray.removeAll()
        favoriteArray.removeAll()
        searchFavoriteArray.removeAll()
        universalItemModel.deleteAllDB()
    }

    @objc func downloadMonsterPosts(endPoint: String, topCompletion: @escaping () -> Void, failure: @escaping (String) -> Void) {
        autoreleasepool {
            self.requestService.sendGetReqest(
                type: SwiftClassFactory.getNewCommonRequestClass(),
                endPoint: endPoint,
                completion: { res in

                    UDService.writeToUserDefaults(str: res.next ?? "", key: "NextArray")
                    self.universalItemModel.addPostToDB(monster: res.results)

                    let dispatchWorkItem = DispatchWorkItem(flags: .barrier) {
                        topCompletion()
                    }
                    DispatchQueue.global().async(execute: dispatchWorkItem)

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
