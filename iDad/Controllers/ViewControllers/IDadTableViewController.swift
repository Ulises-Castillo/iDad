//
//  ViewController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadTableViewController: UITableViewController {

    var iDadList:[IDadViewModel] = []
    let iDadListViewModel = IDadListViewModel() //TODO: auto use local data if offline
    var iDadListKVO: NSKeyValueObservation? = nil
    
    private let reusableCellID = "IDadTableViewCell"
    private let profileSegueID = "showProfile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
        configureTableView()
        
        observeiDadListSetup()
        
        if let iDads = iDadListViewModel.iDadList {
            iDadList = iDads
        }
    }
    
    func observeiDadListSetup() {
        iDadListKVO = iDadListViewModel.observe(\IDadListViewModel.iDadList, options: .new) { [weak self] (iDadListViewModel, change) in
            guard let iDads = iDadListViewModel.iDadList else {
                return
            }
            self?.iDadList = iDads
            self?.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 252
        let nib = UINib(nibName: reusableCellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reusableCellID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == profileSegueID,
            let row = tableView.indexPathForSelectedRow?.row,
            let profileVC = segue.destination as? IDadProfileTableViewController else {
                return
            }
            profileVC.iDadViewModel = iDadList[row]
    }

    //MARK: table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellID) as? IDadTableViewCell else {
            fatalError("Unable to dequeue reusable cell with identifier \(reusableCellID)")
        }
        // configure cell
        let iDadViewModel = iDadList[indexPath.row]
        cell.nameLabel.text = iDadViewModel.name.prefixedWithLongHyphen() // should any string manipulation be better off in the viewmodel ?
        cell.quoteLabel.text = iDadViewModel.topQuote?.surroundedWithQuotes()
        
        if !USE_NETWORK_DATA {
            cell.profileImageView.image = iDadViewModel.profilePicture
        } else if let profilePictureUrl = iDadViewModel.profilePictureUrl {
            cell.profileImageView.imageFromURL(profilePictureUrl)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? iDadList.count : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: profileSegueID, sender: nil)
    }
}
