//
//  PostModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation


protocol ModelUpdating: AnyObject{
    func updateModel()
    func showError(error:String)
}


final class MonsterModel{
    
    private var isFavorite = false
    
    private var monsterArray : [DBMonster] = []
    
    private var tmpMonsterArray : [DBMonster] = []
    
    private var favoriteArray: [DBMonster] = []
    private var searchFavoriteArray: [DBMonster] = []

    private var searchMonsterArray : [DBMonster] = []
    
    private var postService = PostService()
    
    weak var delegate : ModelUpdating?
    private var monsterType : [String] = []
    
    
    private var searchString: String = ""
    private var searchFilterArray: [String] = []
    
    
    init() {
        updateFromDB()
        if monsterArray.count == 0{
            updatePostsFromInternet()
        }
    }
    
    
    func getFavoriteList(){
        let type = SwiftClassFactory.getDBMonsterClass()
        favoriteArray = postService.getAllFAvoritedPosts(ofType: type)
        searchFavoriteArray = favoriteArray
        searchChanged(str: searchString, filterList: searchFilterArray)

    }
    
    
    func switchToFavorite(isTrue:Bool){
        isFavorite = isTrue
        getFavoriteList()
    }
    
    
    func updatePostsFromInternet(){
        postService.downloadPosts(endPoint: "/api/monsters/", topCompletion: {
            DispatchQueue.main.sync {
                self.updateFromDB()
                self.delegate?.updateModel()
            }
        }, failure: { error in
            self.delegate?.showError(error: error)
            
        })
    }
    
    func deleteFromFavorite(index: Int){
        searchFavoriteArray.remove(at: index)
    }
    
    func getPost(index: String) -> DBMonster?{
        for monster in searchMonsterArray {
            if monster.index == index {
                return monster
            }
        }
        return nil
    }
    
    func clearMonstersArray(){
        monsterArray.removeAll()
        searchMonsterArray.removeAll()
    }
    
    func updateFromDB(){
        
        let type = SwiftClassFactory.getDBMonsterClass()
        monsterArray = self.postService.getAllPosts(ofType: type)
        searchMonsterArray.removeAll()
        searchChanged(str: searchString, filterList: searchFilterArray)
        
        self.monsterArray.forEach{ mstr in
            if !self.monsterType.contains(mstr.type){
                self.monsterType.append(mstr.type)
            }
        }
        self.monsterType.sort()
        
    }
    
    
    func setFaforite(forIndex: Int, value: Bool){
        let type = SwiftClassFactory.getDBMonsterClass()
        let object: DBMonster
        if !isFavorite{object = searchMonsterArray[forIndex]}
        else { object =  searchFavoriteArray[forIndex]}
        
        let myObject = DBMonster(from: object)
        myObject.isFavorite = value
        self.postService.changePostInDB(object: myObject, type: type)
    }
    
    func getAllPosts()->[DBMonster]{
        if !isFavorite{ return searchMonsterArray}
        else { return searchFavoriteArray}
    }
    
    func getAllMonsterTypes()->[String]{
        return monsterType
    }
    
    
    func searchChanged(str: String, filterList:[String]){
        searchString = str
        searchFilterArray = filterList
        if !isFavorite{
            searchMonsterArray.removeAll()
            
            monsterArray.forEach{monster in
                if monster.name.contains(str) || str == "" {
                    if filterList.contains(monster.type) || filterList.count == 0{
                        searchMonsterArray.append(monster)
                    }
                }
            }
        }
        else{
            searchFavoriteArray.removeAll()
            favoriteArray.forEach{monster in
                if monster.name.contains(str) || str == "" {
                    if filterList.contains(monster.type) || filterList.count == 0{
                        searchFavoriteArray.append(monster)
                    }
                }
            }
        }
        
    }
    
}
