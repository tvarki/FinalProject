//
//  DBManager.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 26.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

protocol TableViewChangesDelegate: AnyObject {
    func updateTreeView(deletions: [Int], insertions: [Int], modifications: [Int])
    func reloadTreeView()
    func showError(error: String)
}

class DBManager {
    private var database: Realm?
    var notificationToken: NotificationToken?
    private let condition = NSCondition()
    private let lck = NSLock()

    init() {
        setupRealm()
    }

    // MARK: - get Favorite

    func getFavoriteDataFromDB<P>(type: P.Type) -> Results<P>? where P: MyDBObject {
        guard let database = try? Realm() else { return nil }
        let results = database.objects(type).filter("isFavorite == true").sorted(byKeyPath: "name", ascending: true)
        return results
    }

    // MARK: - Realm SetuP

    func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,

            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {}
            }
        )
        // Для всех рилмов указываем глобальную конфигурацию
        Realm.Configuration.defaultConfiguration = config

        database = try? Realm()
    }

    func getDataFromDB<P: Object>(type: P.Type) -> Results<P>? {
        lck.lock()
        guard let database = try? Realm() else { return nil }
        let results: Results<P> = database.objects(type).sorted(byKeyPath: "name", ascending: true)
        //         let results: Results<P> = database.objects(type)
        lck.unlock()
        return results
    }

    func addData<P: MyDBObject>(object: [P]) {
        lck.lock()
        DispatchQueue(label: "realmBackground").async {
            // Для оперативной очистки памяти
            autoreleasepool {
                // Инстанс рилма должен быть свой для каждой очереди
                guard let database = try? Realm() else { return }
                object.forEach { obj in
                    let item = database.objects(P.self).filter("name = %@", obj.name).first
                    if item == nil {
                        try? database.write {
                            database.add(object)
                        }
                    }
                }
            }
            self.lck.unlock()
        }
    }

    func getItem<P: Object>(index: String, type: P.Type) -> P? {
        guard let database = try? Realm() else { return nil }
        lck.lock()
        let tmp = database.objects(type).filter("name = %@", index).first
        lck.unlock()
        return tmp
    }

    func changeData<P: MyDBObject>(object: P, type: P.Type) {
        guard let database = try? Realm() else { return }
        let item = database.objects(type).filter("name = %@", object.name).first
        if item != nil {
            try? database.write {
                item?.isFavorite = object.isFavorite
                return
            }
        }
    }

    // MARK: - Delete All Data Base

    func deleteAllDatabase() {
        guard let database = try? Realm() else { return }
        try? database.write {
            database.deleteAll()
        }
    }

    func deleteFromDb<P: Object>(object: P) {
        guard let database = try? Realm() else { return }
        try? database.write {
            database.delete(object)
        }
    }

//    func subscribe<P:Object>(tableView : UITableView?, type: P.Type ) {
//        guard let database = try? Realm() else { return }
//        let results = database.objects(type)
//
//        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = tableView else { return }
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                tableView.beginUpdates()
//                tableView.deleteRows(
//                    at: deletions.map({ IndexPath(row: $0, section: 0)}),
//                    with: .automatic
//                )
//                tableView.insertRows(
//                    at: insertions.map({ IndexPath(row: $0, section: 0) }),
//                    with: .automatic
//                )
//                tableView.reloadRows(
//                    at: modifications.map({ IndexPath(row: $0, section: 0) }),
//                    with: .automatic
//                )
//                tableView.endUpdates()
//                //                tableView.reloadData()
//
//            case .error(let error):
//                /// Ошбика может возникнуть только если Realm был создан на бэкграунд очереди
//                fatalError("\(error)")
//            }
//        }
//    }

    func getCount<P: Object>(type: P.Type) -> Int {
        guard let database = try? Realm() else { return 0 }
        lck.lock()
        let items = database.objects(type)
        lck.unlock()
        return items.count
    }
}

// protocol MyObject{
//    dynamic var _id: String { get set }
//    dynamic var mainLabel: String { get set }
// }
