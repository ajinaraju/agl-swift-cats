//
//  Owner.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

typealias People = [Owner]

struct Owner: Codable {
    let name: String?
    let gender: Gender?
    let age: Int?
    let pets: [Pets]?
}

extension Array where Element == Owner {
    var catsSeparatedByGenders: (male : [String], female: [String], other: [String]) {
        var catNamesWithMaleOwner: [String] = []
        var catNamesWithFemaleOwner: [String] = []
        var catNamesWithOtherOwner: [String] = []
        for petOwner in self {
            if let pets = petOwner.pets {
                let catNames = pets.filter {$0.type == .cat}.compactMap{$0.name}
                switch petOwner.gender {
                case .male:
                    catNamesWithMaleOwner.append(contentsOf: catNames)
                case .female:
                    catNamesWithFemaleOwner.append(contentsOf: catNames)
                case .other:
                    catNamesWithOtherOwner.append(contentsOf: catNames)
                default: break
                }
            }
        }
        return (male: catNamesWithMaleOwner,
                female: catNamesWithFemaleOwner,
                other: catNamesWithOtherOwner)
    }
}

