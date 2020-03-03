//
//  VIewModel.swift
//
//
//  Created by Дмитрий Яковлев on 01.03.2020.
//

import Foundation

class MonsterViewModel {
    private var isFavorite = false

    private var monsterService = MonsterService()

    private var monsterArray: [MonsterItem] = []
    private var searchMonsterArray: [MonsterItem] = []

    private var favoriteArray: [MonsterItem] = []
    private var searchFavoriteArray: [MonsterItem] = []

    private var monsterType: [String] = []

    private var emParams: EnumMonsterParametrs = .challenge_rating

    private var searchString: String = ""
    private var searchFilterArray: [String] = []

    weak var delegate: ModelUpdating?

    init() {
        monsterService.start(
            completion: comp, fail: fail
        )
    }

    func comp(array: [MonsterItem]) {
        monsterArray = array
        searchMonsterArray = array
        delegate?.updateModel()
    }

    func fail(error: String) {
        delegate?.showError(error: error)
    }

    func setEMParams(value: EnumMonsterParametrs) {
        emParams = value
    }

    func fillFavoriteList() {
        favoriteArray.removeAll()
        for mstr in monsterArray where mstr.isFavorite {
            favoriteArray.append(mstr)
        }
        searchChanged(str: searchString, filterList: searchFilterArray, params: emParams)
    }

    func switchToFavorite(isTrue: Bool) {
        isFavorite = isTrue
        fillFavoriteList()
    }

    func deleteFromFavorite(index: Int) {
        let monster = searchFavoriteArray[index]
        guard let i = favoriteArray.firstIndex(where: { $0.name == monster.name }) else { return }
        searchFavoriteArray.remove(at: index)
        favoriteArray.remove(at: i)
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
        if !isFavorite {
            return searchMonsterArray[index]
        } else {
            return searchFavoriteArray[index]
        }
    }

    func getPost(name: String) -> MonsterItem? {
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

    func dawnloadNext() {
        monsterService.dawnloadNext(completion: comp, fail: fail)
    }

    func getAllMonsterTypes() -> [String] {
        return monsterService.getAllMonsterTypes(monsterArray: monsterArray)
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

    func clearMonstersArray() {
        monsterArray.removeAll()
    }

    func updatePostsFromInternet() {
        monsterService.updatePostsFromInternet(completion: comp, fail: fail)
    }

    func deleteAll() {
        monsterArray.removeAll()
        searchMonsterArray.removeAll()
        searchFilterArray.removeAll()
        monsterService.deleteAll()
    }

    func setFaforite(forIndex: Int, value: Bool) {
        //        print("Function: \(#function), line: \(#line)")
        let object: MonsterItem
        if !isFavorite {
            object = monsterArray[forIndex]
        } else { object = favoriteArray[forIndex] }
        object.isFavorite = value
        monsterService.setFaforite(item: object)
    }

    func getAllPosts() -> [MonsterItem] {
        //        print("Function: \(#function), line: \(#line)")
        if !isFavorite {
            return monsterArray
        } else { return favoriteArray }
    }

    func fillSearchArray(str: String,
                         filterList: [String],
                         allMonsterArray: [MonsterItem],
                         array: inout [MonsterItem]) {
        var tmpArray: [MonsterItem] = []

        allMonsterArray.forEach { monster in
//            if monster.name.lowercased().contains(str.lowercased()) || str == "" {
            if tnp(monster: monster, str: str, type: emParams) || str == "" {
                if filterList.contains(monster.type.lowercased().firstUppercased) || filterList.count == 0 {
                    tmpArray.append(monster)
                }
            }
        }
        array = tmpArray
    }

    func tnp(monster: MonsterItem, str: String, type: EnumMonsterParametrs) -> Bool {
        switch type {
        case .challenge_rating:
            return monster.challenge_rating == str
        case .name:
            return monster.name.lowercased().contains(str.lowercased())
        case .size:
            return monster.size.lowercased().contains(str.lowercased())
        case .type:
            return monster.type.lowercased().contains(str.lowercased())
        case .other:
            return monster.name.lowercased().contains(str.lowercased())
        }
    }

    func searchChanged(str: String, filterList: [String], params _: EnumMonsterParametrs) {
        //        print("Function: \(#function), line: \(#line) monsterArray.count \(monsterArray.count)")
        if !isFavorite {
            fillSearchArray(str: str, filterList: filterList, allMonsterArray: monsterArray, array: &searchMonsterArray)

        } else {
            fillSearchArray(str: str, filterList: filterList, allMonsterArray: favoriteArray, array: &searchFavoriteArray)
        }
    }

    func getParamsArray() -> [String] {
        return EnumMonsterParametrs.getArray()
    }
}
