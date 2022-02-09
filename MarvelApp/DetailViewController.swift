//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 08/02/22.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        self.navigationItem.rightBarButtonItem = .init(
            image: .init(systemName: "heart"),
            style: .done,
            target: nil,
            action: nil
        )
    }
}
