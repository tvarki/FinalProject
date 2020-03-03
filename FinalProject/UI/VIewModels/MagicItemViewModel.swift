//
//  MagicItemViewModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class MagicItemViewModel {
    private var isFavorite = false

    private var magicItemService = MagicItemService()

    private var magicItemArray: [MagicItem] = []
    private var searchMagicItemArray: [MagicItem] = []

    private var favoriteMagicItemArray: [MagicItem] = []
    private var searchFavoriteMagicItemArray: [MagicItem] = []

    private var monsterType: [String] = []

    private var searchString: String = ""
    private var searchFilterArray: [String] = []

    weak var delegate: ModelUpdating?

    private var emParams: EnumMagicItemParams = .name

    init() {
        magicItemService.start(
            completion: comp, fail: fail
        )
    }

    func comp(array: [MagicItem]) {
        magicItemArray = array
        searchMagicItemArray = array
        delegate?.updateModel()
    }

    func fail(error: String) {
        delegate?.showError(error: error)
    }

    func fillFavoriteList() {
        favoriteMagicItemArray.removeAll()
        for mstr in magicItemArray where mstr.isFavorite {
            favoriteMagicItemArray.append(mstr)
        }
        searchChanged(str: searchString, filterList: searchFilterArray)
    }

    func switchToFavorite(isTrue: Bool) {
        isFavorite = isTrue
        fillFavoriteList()
    }

    func deleteFromFavorite(index: Int) {
        let monster = searchFavoriteMagicItemArray[index]
        guard let i = favoriteMagicItemArray.firstIndex(where: { $0.name == monster.name }) else { return }
        searchFavoriteMagicItemArray.remove(at: index)
        favoriteMagicItemArray.remove(at: i)
    }

    func getGlobalCount() -> Int {
        return magicItemArray.count
    }

    func getCount() -> Int {
        if !isFavorite {
            return searchMagicItemArray.count
        } else {
            return searchFavoriteMagicItemArray.count
        }
    }

    func getPost(index: Int) -> MagicItem {
        if !isFavorite {
            return searchMagicItemArray[index]
        } else {
            return searchFavoriteMagicItemArray[index]
        }
    }

    func getPost(name: String) -> MagicItem? {
        for monster in searchMagicItemArray where monster.name == name {
            return monster
        }
        return nil
    }

    func getName(of index: Int) -> String {
        var name: String
        if !isFavorite {
            name = searchMagicItemArray[index].getName()
        } else {
            name = searchFavoriteMagicItemArray[index].getName()
        }
        return name
    }

    func dawnloadNext() {
        magicItemService.dawnloadNext(completion: comp, fail: fail)
    }

    func getAllMonsterTypes() -> [String] {
        return magicItemService.getAllMonsterTypes(magicItemArray: magicItemArray)
    }

    func getDetail(of index: Int) -> String {
        var detail: String
        if !isFavorite {
            detail = searchMagicItemArray[index].getDetail()
        } else {
            detail = searchFavoriteMagicItemArray[index].getDetail()
        }
        return detail
    }

    func clearMonstersArray() {
        magicItemArray.removeAll()
    }

    func updatePostsFromInternet() {
        magicItemService.updatePostsFromInternet(completion: comp, fail: fail)
    }

    func deleteAll() {
        magicItemArray.removeAll()
        searchMagicItemArray.removeAll()
        searchFilterArray.removeAll()
        searchFilterArray.removeAll()
        magicItemService.deleteAll()
    }

    func setEMParams(value: EnumMagicItemParams) {
        emParams = value
    }

    func getParamsArray() -> [String] {
        return EnumMagicItemParams.getArray()
    }

    func setFaforite(forIndex: Int, value: Bool) {
        //        print("Function: \(#function), line: \(#line)")
        let object: MagicItem
        if !isFavorite {
            object = magicItemArray[forIndex]
        } else { object = favoriteMagicItemArray[forIndex] }
        object.isFavorite = value
        magicItemService.setFaforite(item: object)
    }

    func getAllPosts() -> [MagicItem] {
        //        print("Function: \(#function), line: \(#line)")
        if !isFavorite {
            return magicItemArray
        } else { return favoriteMagicItemArray }
    }

    func fillSearchArray(str: String,
                         filterList: [String],
                         allMagicItemArray: [MagicItem],
                         array: inout [MagicItem]) {
        var tmpArray: [MagicItem] = []
        allMagicItemArray.forEach { item in
            if tnp(itm: item, str: str, type: emParams) || str == "" {
                if filterList.contains(item.type.lowercased().firstUppercased) || filterList.count == 0 {
                    tmpArray.append(item)
                }
            }
        }
        array = tmpArray
    }

    func tnp(itm: MagicItem, str: String, type: EnumMagicItemParams) -> Bool {
        switch type {
        case .rarity:
            return itm.rarity.lowercased().contains(str.lowercased())
        case .name:
            return itm.name.lowercased().contains(str.lowercased())
        case .other:
            return itm.name.lowercased().contains(str.lowercased())
        }
    }

    func searchChanged(str: String, filterList: [String]) {
        //        print("Function: \(#function), line: \(#line) monsterArray.count \(monsterArray.count)")
        if !isFavorite {
            fillSearchArray(str: str, filterList: filterList, allMagicItemArray: magicItemArray, array: &searchMagicItemArray)

        } else {
            fillSearchArray(str: str, filterList: filterList, allMagicItemArray: favoriteMagicItemArray, array: &searchFavoriteMagicItemArray)
        }
    }
}
