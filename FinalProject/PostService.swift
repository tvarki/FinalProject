//
//  Posts.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 26.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

class PostService{
    
    
    let requestService = RequestsService()
    let dbManager = DBManager()
    private var count = 0
    let batchSize = 2
    var timer = Timer()
    
    init(){
        
    }
    
    //MARK:- get all data from DB
    func getAllPosts<P:Object>(ofType: P.Type)->[P]{
        guard let tmp = dbManager.getDataFromDB(type: ofType)
            else {return []}
        return Array(tmp)
    }
    
    func getAllFAvoritedPosts<P:Object>(ofType: P.Type)->[P] where P: MyDBObject{
        guard let tmp = dbManager.getFavoriteDataFromDB(type: ofType)
            else {return []}
        return Array(tmp)
    }
    
//    //MARK:- subscride
//    func subscribe<P: Object>(myTableView: UITableView,type: P.Type){
//        dbManager.subscribe(tableView: myTableView, type: type)
//    }
    
    //MARK:- add data to DB
    func addPostToDB<P>(post: P) where P: MyDBObject{
        dbManager.addData(object: post)
    }
    
    //MARK:- change post in DB
    func changePostInDB<P>(object: P, type: P.Type) where P: MyDBObject{
        dbManager.changeData(object: object, type: type)
    }
    
    //MARK:- get post by id
    func getPost<P: Object>(index: String, type: P.Type) -> P?{
        let tmp = dbManager.getItem(index:index, type: type)
        return tmp
    }
    
    //MARK:- delete objewct from db
    func deleteFromDB<P:Object>(object: P){
        count -= 1
        dbManager.deleteFromDb(object: object)
    }
    
    //MARK:- delete all data from DB
    func deleteAllDB(){
        count = 0
        dbManager.deleteAllDatabase()
    }
    
    func getItemsCount<P:Object>(type: P.Type)-> Int{
        return dbManager.getCount(type: type)
    }
    
    
    
    //MARK:- Sownload batchSize count posts
    @objc func downloadPosts(endPoint: String, topCompletion: @escaping ()->(), failure: @escaping (String)->()){
        DispatchQueue(label: "background").async {
            /// Для оперативной очистки памяти
            autoreleasepool {
                
                self.requestService.sendGetReqest(
                    type: SwiftClassFactory.getCommonRequestClass(),
                    endPoint: endPoint,
                    completion: { res  in
                        
                        for tmp in res.results{
                            self.requestService.sendGetReqest(
                                type: SwiftClassFactory.getMonsterClass(),
                                endPoint: tmp.url,
                                completion: { res1  in
                                    //                                    print ("1")
                                    let test2 = (SwiftClassFactory.createDBMonsterClass(tmp: res1))
                                    self.addPostToDB(post: test2)          
                                    topCompletion()
                            },
                                failure: { error in
                                    DispatchQueue.main.async {
                                        print(error)
                                    }
                            })
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

