//
//  ResultExtensions.swift
//  SwiftCats
//
//  Created by Ajina Raju George on 4/20/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import Foundation

extension Result {
    func unwrap(success: (Success)->Void, failure: (Error)->Void) {
        switch self {
        case .success(let value):
            success(value)
        case .failure(let error):
            failure(error)
        }
    }
}
