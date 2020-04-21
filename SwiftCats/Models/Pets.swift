//
//  Pet.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import Foundation

struct Pets: Codable {
    let name: String?
    let type: PetType?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
    }
}
