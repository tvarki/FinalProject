//
//  MagicItem.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class MagicItem {
    let slug: String
    let name: String
    let type: String
    let desc: String
    let rarity: String
    let requires_attunement: String
    let document__slug: String
    let document__title: String
    var isFavorite: Bool = false

    init() {
        slug = ""
        name = ""
        type = ""
        desc = ""
        rarity = ""
        requires_attunement = ""
        document__slug = ""
        document__title = ""
        isFavorite = false
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

    func getName() -> String {
        return name
    }

    func getDetail() -> String {
        return "🔎: \(rarity) 📌: \(type)"
    }

    func toString() -> String {
        var tmp: String = ""
        tmp.append("Item ".makeBold() + name.addLineBreaker())
        tmp.append("Rarity ".makeBold() + rarity.addLineBreaker())
        tmp.append("Description ".makeBold() + desc.addLineBreaker())
        return tmp
    }
}
