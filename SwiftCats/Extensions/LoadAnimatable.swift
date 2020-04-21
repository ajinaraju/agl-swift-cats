//
//  LoadAnimatable.swift
//  SwiftCats
//
//  Created by Ajina Raju George on 4/21/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol LoadAnimatable: NVActivityIndicatorViewable {
    func startLoadAnimation()
    func stopLoadingAnimation()
}

extension LoadAnimatable where Self: UITableViewController {
    func startLoadAnimation() {
        let size = CGSize(width: 40, height: 40)
        startAnimating(size, message: "Loading...", type: .ballRotate)
    }
    
    func stopLoadingAnimation() {
        stopAnimating()
    }
}
