//
//  IDadProfileViewController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadProfileTableViewController: UITableViewController {

    var iDadViewModel: IDadViewModel! // ViewModel will always be assigned, no other way to get to this viewController
    let model: [[UIColor]] = Utils.generateRandomColor2DArray()
    var collectionViewsStoredOffsets = [Int: CGFloat]()
    
    private let reusableTableViewCellID = "CollectionViewTableViewCell"
    private let reusableCollectionViewCellID = "CollectionViewCell"
    
    enum ContentRow: Int, CaseIterable {
        case videos // "= 0" not required - first case starts at zero by default
        case quotes
        case books
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        title = iDadViewModel?.name
        
        configureIDadProfileHeaderView()
    }
    
    func configureIDadProfileHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
        headerView.backgroundColor = .purple
        tableView.tableHeaderView = headerView
    }
    
//MARK: tableView
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = ContentRow(rawValue: indexPath.row) else {
            return 140
        }
        switch row {
        case ContentRow.videos:
            return VideosRow.heightForRow()
        case ContentRow.quotes:
            return QuotesRow.heightForRow()
        default:
            return 140
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? model.count : 0 // TODO: swap out mock data
//        return section == 0 ? ContentRow.allCases.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableTableViewCellID) as? CollectionViewTableViewCell else {
            fatalError("Unable to dequeue reusable cell with identifier \(reusableTableViewCellID)")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CollectionViewTableViewCell else { return }
        
        // set embedded collectionView's dataSource & delegate
        // pass in row to identify collectionView
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        
        // restore saved offset or set to 0 if new
        tableViewCell.collectionViewOffset = collectionViewsStoredOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CollectionViewTableViewCell else { return }
        
        // store collectionView offset by row
        collectionViewsStoredOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

//MARK: collectionView
extension IDadProfileTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        }
        
        switch row {
        case ContentRow.videos:
            return VideosRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        case ContentRow.quotes:
            return QuotesRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        default:
            return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        }
    }
}

extension IDadProfileTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return section == 0 ? model[collectionView.tag].count : 0
        }
        
        switch row {
        case ContentRow.videos:
            return VideosRow.numberOfItemsInSection(section: section)
        case ContentRow.quotes:
            return QuotesRow.numberOfItemsInSection(section: section, quotes: iDadViewModel.quotes)
        default:
            return section == 0 ? model[collectionView.tag].count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCollectionViewCellID, for: indexPath)
            cell.backgroundColor = model[collectionView.tag][indexPath.item]
            return cell
        }
        
        switch row {
        case ContentRow.videos:
            return VideosRow.cell(collectionView: collectionView, indexPath: indexPath)
        case ContentRow.quotes:
            return QuotesRow.cell(collectionView: collectionView, indexPath: indexPath, quotes: iDadViewModel.quotes)
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCollectionViewCellID, for: indexPath)
            cell.backgroundColor = model[collectionView.tag][indexPath.item]
            return cell
        }
        
    }
}
