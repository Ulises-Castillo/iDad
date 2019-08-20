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
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        iDads = iDadListViewModel.iDadList
    }

    //MARK: table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "iDadCell") else {
            return UITableViewCell()
        }
        let iDadViewModel = iDads[indexPath.row]
        cell.textLabel?.text = iDadViewModel.name
        cell.imageView?.image = iDadViewModel.profilePicture
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iDads.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            segue.destination.title = iDads[row].name
        }
    }
}

