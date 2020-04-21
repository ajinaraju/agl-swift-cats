//
//  MockNetworkServiceStub.swift
//  SwiftCatsTests
//
//  Created by Ajina Raju George on 4/21/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import XCTest

@testable import SwiftCats

class MockNetworkServiceSuccessStub: NetworkServiceProtocol {

    func getPeople(completion: @escaping (Result<People, Error>) -> Void) {
         let models = MockPeopleListGenerator.getPeopleList()!
         completion(.success(models))
    }
}

class MockNetworkServiceFailureStub: NetworkServiceProtocol {

    func getPeople(completion: @escaping (Result<People, Error>) -> Void) {
        completion(.failure((ServerError.dataTransformation)))
    }
}
