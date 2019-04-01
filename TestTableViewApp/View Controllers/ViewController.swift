//
//  ViewController.swift
//  TestTableViewApp
//
//  Created by Preet on 2019-03-25.
//  Copyright © 2019 Preetinder Kaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var teams: [TeamList] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getListFromFile()
        setNavBar()
        self.tableView.register(UINib(nibName: "TeamsHeaderView", bundle: Bundle.main), forCellReuseIdentifier: "TeamsHeaderView")
    }
    
    func setNavBar() {
        let rightButton = UIBarButtonItem(title: "Sort By", style: .done, target: self, action: #selector(sortByList))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func sortByList() {
        let actionSheet = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        let sortByWins = UIAlertAction(title: "Win", style: .default) { _ in
            self.teams.sort(by: { $0.wins > $1.wins})
            self.tableView.reloadData()
        }
        actionSheet.addAction(sortByWins)
        
        let sortByLosses = UIAlertAction(title: "Losses", style: .default) { _ in
            self.teams.sort(by: { $0.losses > $1.losses})
            self.tableView.reloadData()
        }
        actionSheet.addAction(sortByLosses)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func getDataFromFile() {
        if let path = Bundle.main.path(forResource: "list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [Any] {
                    print(jsonResult)
                }
            } catch {
                
            }
            
        }
    }
    
    func getListFromFile() {
        if let path = Bundle.main.path(forResource: "list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonList = try JSONDecoder().decode([TeamList].self, from: data)
                teams = jsonList
                teams.sort(by: { $0.fullName < $1.fullName})
//                teams.sort(by: { $0.wins > $1.wins})
            } catch {
                
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
        cell.name.text = teams[indexPath.row].fullName
        cell.win.text = String(teams[indexPath.row].wins)
        cell.losses.text = String(teams[indexPath.row].losses)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: "TeamsHeaderView")
        headerView?.contentView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController: DetailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.players = teams[indexPath.row].players
        detailViewController.title = teams[indexPath.row].fullName
        detailViewController.headerTitle = "\(teams[indexPath.row].wins) Wins" + " and \(teams[indexPath.row].losses) Losses"
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

