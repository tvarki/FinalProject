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
            schemaVersion: 2,

            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 2 {}
            }
        )
        Realm.Configuration.defaultConfiguration = config

        database = try? Realm()
    }

    func getDataFromDB<P: Object>(type: P.Type) -> Results<P>? {
        lck.lock()
        guard let database = try? Realm() else { return nil }
        let results: Results<P> = database.objects(type).sorted(byKeyPath: "name", ascending: true)
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
        lck.lock()
        let item = database.objects(type).filter("name = %@", object.name).first
        if item != nil {
            try? database.write {
                item?.isFavorite = object.isFavorite
                return
            }
        }
        lck.unlock()
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

    func getCount<P: Object>(type: P.Type) -> Int {
        guard let database = try? Realm() else { return 0 }
        lck.lock()
        let items = database.objects(type)
        lck.unlock()
        return items.count
    }
}
