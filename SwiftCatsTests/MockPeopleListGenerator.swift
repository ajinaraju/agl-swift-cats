//
//  MockPeopleListGenerator.swift
//  SwiftCatsTests
//
//  Created by Ajina Raju George on 4/21/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import XCTest
@testable import SwiftCats

class MockPeopleListGenerator {
    
    class func getData(fileName: String, type: String) -> Data {
        let path = Bundle(for: MockPeopleListGenerator.self).path(forResource: fileName, ofType: type)!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data
    }
    
    class func getPeopleList() ->  People? {
        let result = convertJsonToModel(responseData: getData(fileName: "content", type: "json"))
        switch result {
        case .failure:
            return nil
        case .success(let people):
            return people
        }
    }
    
    class func convertJsonToModel(responseData: Data) -> Result<People, Error> {
        do {
            let peopleList = try JSONDecoder().decode(People.self, from: responseData)
            return.success(peopleList)
        } catch let error {
            return.failure(error)
        }
    }
    
}
