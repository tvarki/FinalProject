//
//  NewDBMagicItem.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
import RealmSwift

class NewDBMagicItem: Object, MyDBObject {
    @objc dynamic var slug: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var rarity: String = ""
    @objc dynamic var requires_attunement: String = ""
    @objc dynamic var document__slug: String = ""
    @objc dynamic var document__title: String = ""
    @objc dynamic var isFavorite: Bool = false

    override static func primaryKey() -> String? {
        return "name"
    }

    init(from: MagicItem) {
        slug = from.slug
        name = from.name
        type = from.type
        desc = from.desc
        rarity = from.rarity
        requires_attunement = from.requires_attunement
        document__slug = from.slug
        document__title = from.document__title
        isFavorite = from.isFavorite
    }

    init(from: NewDBMagicItem) {
        slug = from.slug
        name = from.name
        type = from.type
        desc = from.desc
        rarity = from.rarity
        requires_attunement = from.requires_attunement
        document__slug = from.slug
        document__title = from.document__title
        isFavorite = from.isFavorite
    }

    init(from: MagicItemDTO) {
        slug = from.slug
        name = from.name
        type = from.type
        desc = from.desc
        rarity = from.rarity
        requires_attunement = from.requires_attunement
        document__slug = from.slug
        document__title = from.document__title
        isFavorite = false
    }

    required init() {}
}
