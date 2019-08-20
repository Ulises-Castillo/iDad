//
//  ViewController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadTableViewController: UITableViewController {

    var iDads:[IDadViewModel] = []
    let iDadListViewModel = IDadListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        iDads = iDadListViewModel.iDadList //TODO: dynamically observe listViewModel (KVO)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showProfile",
            let row = tableView.indexPathForSelectedRow?.row,
            let profileVC = segue.destination as? IDadProfileViewController else { return }
        
            profileVC.iDad = iDads[row]
    }

    //MARK: table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue cell
        let reusableCellID = "iDadCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellID) else {
            fatalError("Unable to dequeue reusable cell with identifier \(reusableCellID)")
        }
        
        // configure cell
        let iDadViewModel = iDads[indexPath.row]
        cell.textLabel?.text = iDadViewModel.name
        cell.detailTextLabel?.text = iDadViewModel.topQuote
        cell.imageView?.image = iDadViewModel.profilePicture
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? iDads.count : 0
    }
}

