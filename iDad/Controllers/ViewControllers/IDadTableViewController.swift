//
//  ViewController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadTableViewController: UITableViewController {

    private var iDadList:[IDadViewModel] = []
    private let iDadListViewModel = IDadListViewModel() //TODO: auto use local data if offline
    private var iDadListKVO: NSKeyValueObservation? = nil
    
    private var dataSource: UITableViewDiffableDataSource<Section, IDadViewModel>!
    
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
            self?.updateDataSource()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == profileSegueID,
            let row = tableView.indexPathForSelectedRow?.row,
            let profileVC = segue.destination as? IDadProfileTableViewController else {
                return
            }
            profileVC.iDadViewModel = iDadList[row]
    }
}

//MARK: table view
extension IDadTableViewController {
    fileprivate enum Section {
        case first
    }
    
    func configureTableView() {
        tableView.rowHeight = view.bounds.height / 3.9
        tableView.register(IDadTableViewCell.self, forCellReuseIdentifier: IDadTableViewCell.id)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IDadTableViewCell.id, for: indexPath) as? IDadTableViewCell else { return UITableViewCell() }
            
            cell.set(with: model)
            return cell
        })
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, IDadViewModel>()
        snapshot.appendSections([.first])
        snapshot.appendItems(iDadList)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? iDadList.count : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: profileSegueID, sender: nil)
    }
}

    
