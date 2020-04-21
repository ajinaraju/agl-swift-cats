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

protocol DecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: DecoderProtocol {}

protocol NetworkSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSessionProtocol {}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    let decoder: DecoderProtocol
    let session: NetworkSessionProtocol

    init(decoder: DecoderProtocol = JSONDecoder(),
         session: NetworkSessionProtocol = URLSession.shared) {
        self.decoder = decoder
        self.session = session
    }

    func getPeople(completion: @escaping (Result<People, Error>) -> Void) {
        guard let url = URL(string: WebServiceConstants.EndPoint.getPeople.path) else {
            completion(.failure(NSError()))
            return
        }
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

