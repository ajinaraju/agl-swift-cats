//
//  ViewController.swift
//  SwiftCats
//
//  Created by Yilei He on 3/4/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//
import UIKit

final class PeopleListViewController: UITableViewController, AlertPresentable, LoadAnimatable {
    
    let viewModel = PeopleListViewModel()
    let refreshContrlr = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureViewModel()
        viewModel.fetchPeopleList()
    }
    
    private func configureView() {
        refreshContrlr.addTarget(self, action: #selector(reloadAction(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshContrlr
        title = "Cat List"
    }
    
    @objc
    func reloadAction(sender: Any) {
        viewModel.fetchPeopleList()
    }
    
    private func configureViewModel() {
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.tableView.reloadData()
            }
        }
        
        viewModel.updateLoadingStatus = {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                
                if weakSelf.viewModel.isLoading {
                    weakSelf.startLoadAnimation()
                    weakSelf.refreshContrlr.beginRefreshing()
                } else {
                    weakSelf.stopAnimating()
                    weakSelf.refreshContrlr.endRefreshing()
                }
            }
        }
        
        viewModel.showAlertMessage = { [weak self] message in
            guard let weakSelf = self else { return }
            
            weakSelf.showAlert(title: weakSelf.title,
                               message: message)
        }
        
    }
    
    // Mark: -  TableView  DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(at: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsinSection(at: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath)
        cell.textLabel?.text = viewModel.titleForRow(at: indexPath.section, in: indexPath.row)
        return cell
    }
}

