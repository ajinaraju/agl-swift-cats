//
//  NetworkService.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import Foundation

final class NetworkService {
    func getOwners(completionHandler: @escaping ([Owner]) -> Void) {
        let url = URL(string: "https://agl-developer-test.azurewebsites.net/people.json")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let owners = try? JSONDecoder().decode([Owner].self, from: data) else { return }
            completionHandler(owners)
        }.resume()
    }
}
