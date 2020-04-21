//
//  Owner.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import Foundation

typealias People = [Owner]

struct Owner: Codable {
    let name: String?
    let gender: Gender?
    let age: Int?
    let pets: [Pets]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case gender = "gender"
        case age = "age"
        case pets = "pets"
    }
}
