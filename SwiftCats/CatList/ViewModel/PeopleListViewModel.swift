//
//  PeopleListViewModel.swift
//  SwiftCats
//
//  Created by Ajina Raju George on 4/19/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import UIKit

class PeopleListViewModel {
    let networkService: NetworkServiceProtocol
    
    var isLoading = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var peopleCellViewModel: [PeopleCellViewModel] = [] {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var showAlertMessage: ((String) -> Void)?
    var reloadTableView: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var showEarthquake: ((_ owner: PeopleListViewModel) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchPeopleList() {
        isLoading = true
        
        networkService.getPeople() { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.isLoading = false
            result.unwrap(success: { owners in
                weakSelf.processFetched(owners: owners)
            }, failure: { error in
                weakSelf.showAlertMessage?(error.localizedDescription)
            })
        }
    }
    
    private func processFetched(owners: People) {
        peopleCellViewModel.removeAll()
        let allCats = owners.catsSeparatedByGenders

        let catsWithMaleOwners = PeopleCellViewModelBuilder.build(from: allCats.male,
                                                                  gender: .male)
        peopleCellViewModel.append(catsWithMaleOwners)

        let catsWithFemaleOwners = PeopleCellViewModelBuilder.build(from: allCats.female,
                                                                gender: .female)
        peopleCellViewModel.append(catsWithFemaleOwners)

        let catsWithOtherOwners = PeopleCellViewModelBuilder.build(from:allCats.other,
                                                                   gender: .other)
        if catsWithOtherOwners.names.count > 0 {
            peopleCellViewModel.append(catsWithOtherOwners)
        }
    }
}

struct PeopleCellViewModelBuilder {
    static func build(from names: [String], gender: Gender) -> PeopleCellViewModel {
        return PeopleCellViewModel(names: names.sorted(by: <), gender: gender)
    }
}

// TableView helpers

extension PeopleListViewModel {
    
    var numberOfSections: Int {
        return peopleCellViewModel.count
    }
    
    func sectionTitle(at sectionIndex: Int) -> String? {
        return peopleCellViewModel[sectionIndex].gender.rawValue
    }
    
    func numberOfRowsinSection(at section: Int) -> Int {
        return peopleCellViewModel[section].names.count
    }
    
    func titleForRow(at section:Int, in row:Int) -> String {
        return peopleCellViewModel[section].names[row]
    }
    
    
}


