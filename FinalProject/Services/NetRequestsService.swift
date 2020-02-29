//
//  RequestsService.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 17.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

struct NetRequestsService {
    var netCore = NetCore()

    func sendGetReqest<T: Decodable>(
        type: T.Type,
        endPoint: String,
        completion: @escaping (T) -> Void,
        failure: ((String) -> Void)?
    ) {
        netCore.sendRequest(
            endPoint: endPoint,
            httpMethod: .GET,
            headers: ["Content-Type": "application/json"],
            parseType: type

        ) { result in
            switch result {
            case let .error(error):
                print(error)
                failure?(error)
            case let .some(object):
                completion(object)
            }
        }
    }
}
