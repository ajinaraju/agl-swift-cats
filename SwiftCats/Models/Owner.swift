//
//  Owner.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let name: String
    let gender: String
    let age: Int
    let pets: [Pet]
}
