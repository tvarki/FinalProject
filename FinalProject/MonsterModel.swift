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

    let requestService = RequestsService()
    
    private var isFavorite = false
    
    private var monsterArray : [NewDBMonster] = []
    
    private var tmpMonsterArray : [NewDBMonster] = []
    
    private var favoriteArray: [NewDBMonster] = []
    private var searchFavoriteArray: [NewDBMonster] = []
    
    private var searchMonsterArray : [NewDBMonster] = []
    
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
        let type = SwiftClassFactory.getNewDBMonsterClass()
        favoriteArray = postService.getAllFAvoritedPosts(ofType: type)
        searchFavoriteArray = favoriteArray
        searchChanged(str: searchString, filterList: searchFilterArray)
        
    }
    
    
    func switchToFavorite(isTrue:Bool){
        isFavorite = isTrue
        getFavoriteList()
    }
    
    
    func updatePostsFromInternet(){
        self.downloadMonsterPosts(endPoint: "monsters/", topCompletion: {
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
    
    func getPost(index: String) -> NewDBMonster?{
        for monster in searchMonsterArray {
            if monster.name == index {
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
        
        let type = SwiftClassFactory.getNewDBMonsterClass()
        monsterArray = self.postService.getAllPosts(ofType: type)
        searchMonsterArray.removeAll()
        searchChanged(str: searchString, filterList: searchFilterArray)
        
        self.monsterArray.forEach{ mstr in
            if !self.monsterType.contains(mstr.type.lowercased()){
                self.monsterType.append(mstr.type.lowercased())
            }
        }
        self.monsterType.sort()
        
    }
    
    func setFaforite(forIndex: Int, value: Bool){
        let type = SwiftClassFactory.getNewDBMonsterClass()
        let object: NewDBMonster
        if !isFavorite{object = searchMonsterArray[forIndex]}
        else { object =  searchFavoriteArray[forIndex]}
        
        let myObject = NewDBMonster(from: object)
        myObject.isFavorite = value
        self.postService.changePostInDB(object: myObject, type: type)
    }
    
    func getAllPosts()->[NewDBMonster]{
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
                    if filterList.contains(monster.type.lowercased()) || filterList.count == 0{
                        searchMonsterArray.append(monster)
                    }
                }
            }
        }
        else{
            searchFavoriteArray.removeAll()
            favoriteArray.forEach{monster in
                if monster.name.contains(str) || str == "" {
                    if filterList.contains(monster.type.lowercased()) || filterList.count == 0{
                        searchFavoriteArray.append(monster)
                    }
                }
            }
        }
    }
    
    @objc func downloadMonsterPosts(endPoint: String, topCompletion: @escaping ()->(), failure: @escaping (String)->()){
            DispatchQueue(label: "background").async {
                /// Для оперативной очистки памяти
                autoreleasepool {
                    
                    self.requestService.sendGetReqest(
                        type: SwiftClassFactory.getNewCommonRequestClass(),
                        endPoint: endPoint,
                        completion: { res  in
                            res.results.forEach{ r in
                                let test2 = (SwiftClassFactory.createNewDBMonsterClass(tmp: r))
                                self.postService.addPostToDB(post: test2)
                            }
                            topCompletion()
                            if res.next != nil{
                                self.downloadMonsterPosts(endPoint: res.next!, topCompletion:                               topCompletion, failure: failure)
                            }
                    },
                            failure: { error in
                                DispatchQueue.main.async {
                                    failure(error)
    //                                print(error)
                                }
                    })
                }
            }
        }
    
}
