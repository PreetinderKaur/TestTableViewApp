//
//  DetailViewController.swift
//  TestTableViewApp
//
//  Created by Preet on 2019-03-25.
//  Copyright © 2019 Preetinder Kaur. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var players: [Player] = []
    let teamWins: String = ""
    let teamLosses: String = ""
    var headerTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
        cell.name.text = players[indexPath.row].firstName + " " + players[indexPath.row].lastName
        cell.win.text = String(Substring(players[indexPath.row].position.rawValue))
        cell.losses.text = String(players[indexPath.row].number)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
}
