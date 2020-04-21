//
//  AlertPresentable.swift
//  SwiftCats
//
//  Created by Ajina Raju George on 4/20/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String?, message: String?)
}

extension AlertPresentable where Self: UITableViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

