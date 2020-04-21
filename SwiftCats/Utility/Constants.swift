//
//  Constants.swift
//  SwiftCats
//
//  Created by Ajina Raju George on 4/19/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

enum WebServiceConstants {
    static let baseURL = "https://agl-developer-test.azurewebsites.net/"
    enum EndPoint {
        case getPeople
        var path: String {
            switch self {
            case .getPeople:
                return baseURL + "people.json"
            }
        }
    }
}
