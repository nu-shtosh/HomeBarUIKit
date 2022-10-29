//
//  DeveloperListViewController.swift
//  HomeBar
//
//  Created by Armen Madoyan on 30.10.2022.
//

import UIKit

class DeveloperListViewController: UITableViewController {
    
    private var developerList = Developer.getDeveloperList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.separatorColor = UIColor(red: 1, green: 0.216, blue: 0.373, alpha: 1)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developerList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developer", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let developer = developerList[indexPath.row]
        let background = UIView()
        
        background.backgroundColor = UIColor(red: 1, green: 0.216, blue: 0.373, alpha: 0.35)
        content.text = developer.fullname
        content.textProperties.color = UIColor.white
        content.image = UIImage(named: developer.photo)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.selectedBackgroundView = background
        cell.contentConfiguration = content

        return cell
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DeveloperDetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailsVC.devInfo = developerList[indexPath.row]
    }
}
