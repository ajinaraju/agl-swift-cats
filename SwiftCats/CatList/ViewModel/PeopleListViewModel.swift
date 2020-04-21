//
//  PeopleListViewModel.swift
//  SwiftCats
//
//  Created by Ajina Raju George on 4/19/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import UIKit

class PeopleListViewModel {
    let networkService: NetworkServiceProtocol!
    
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
        var catNamesWithMaleOwner: [String] = []
        var catNamesWithFemaleOwner: [String] = []
        var catNamesWithOtherOwner: [String] = []
        
        for petOwner in owners {
            if let pets = petOwner.pets {
                let catNames = pets.filter {$0.type == PetType.cat}.compactMap({return $0.name})
                switch petOwner.gender {
                case .Male:
                    catNamesWithMaleOwner.append(contentsOf: catNames)
                case .Female:
                    catNamesWithFemaleOwner.append(contentsOf: catNames)
                case .Other:
                    catNamesWithOtherOwner.append(contentsOf: catNames)
                default:
                    break
                }
            }
        }
        
        let catsWithMaleOwners: PeopleCellViewModel = PeopleCellViewModel(names: catNamesWithMaleOwner.sorted(by: <), gender: Gender.Male)
        let catsWithFeMaleOwners: PeopleCellViewModel = PeopleCellViewModel(names: catNamesWithFemaleOwner.sorted(by: <), gender: Gender.Female)
        let catsWithOtherOwners: PeopleCellViewModel = PeopleCellViewModel(names: catNamesWithOtherOwner.sorted(by: <), gender: Gender.Other)
        peopleCellViewModel.append(catsWithMaleOwners)
        peopleCellViewModel.append(catsWithFeMaleOwners)
        if catsWithOtherOwners.names.count > 0 {
            peopleCellViewModel.append(catsWithOtherOwners)
        }
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


