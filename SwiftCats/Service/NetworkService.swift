//
//  NetworkService.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPeople(completion: @escaping (Result<People, Error>) -> Void)
}

enum ServerError: String, Error {
    case dataTransformation
    
    var localizedDescription: String {
        switch self {
        case .dataTransformation:
            return "Unable to parse the JSON"
        }
    }
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    let decoder = JSONDecoder()
    
    func getPeople(completion: @escaping (Result<People, Error>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: WebServiceConstants.peopleURL)!
        session.dataTask(with: url) {[weak self] (data, response, error) in
            guard let weakSelf = self else { return }
            
            if let error = error {
                completion(.failure(error))
            }
            else if
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let responseData = data {
                do {
                    let people = try weakSelf.decoder.decode(People.self, from: responseData)
                    completion(.success(people))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            } else {
                completion(.failure(ServerError.dataTransformation))
            }
        }.resume()
    }
}

