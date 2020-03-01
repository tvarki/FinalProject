//
//  udService.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation
class UDService {
    // MARK: - writeToUserDefaults

    static func writeToUserDefaults(str: String, key: String) {
        UserDefaults.standard.set(str, forKey: key)
    }

    // MARK: - getFromUserDefaults

    static func getFromUserDefaults(key: String) -> String? {
        guard let a = UserDefaults.standard.object(forKey: key) as? String
        else { return nil }
        return a
    }
}
