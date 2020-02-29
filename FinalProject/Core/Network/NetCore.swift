//
//  NetModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 17.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
    case PATCH
    case HEAD
}

enum Result<T> {
    case some(object: T)
    case error(description: String)
}

class NetCore {
    let baseURL = "https://api.open5e.com/"

    func sendRequest<U: Decodable>(
        endPoint: String,
        httpMethod: HTTPMethod = .GET,
        headers: [String: String],
        parseType: U.Type,
        completion: @escaping (Result<U>) -> Void
    ) {
        let urlString: String
        if endPoint.contains(baseURL) {
            urlString = endPoint
        } else {
            urlString = baseURL + endPoint
        }
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(Result.error(description: error.localizedDescription))
            }
            if
                let data = data {
                do {
                    let result = try JSONDecoder().decode(parseType, from: data)
                    completion(Result.some(object: result))
                } catch {
                    print(error)
                    completion(Result.error(description: error.localizedDescription))
                }
            } else {
                completion(Result.error(description: "C сервера не пришли данные"))
            }
        }
        task.resume()
    }
}
