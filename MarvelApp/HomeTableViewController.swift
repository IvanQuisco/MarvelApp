//
//  HomeTableViewController.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 08/02/22.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var characters: [CharacterUIModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(CharacterCell.self, forCellReuseIdentifier: "cellId")
        
        Network.fetchCharacters { [weak self] result in
            if let self = self, case let .success(value) = result {
                self.characters = value
            }
        }
    }
}

extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CharacterCell
        cell.character = characters[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController()
        controller.character = characters[indexPath.row]
        controller.view.backgroundColor = self.view.backgroundColor
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
