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
    var collectionViewsStoredOffsets = [Int: CGFloat]()
    var quotesColorArray = [UIColor]()
    
    let videosRow = VideosRowController()
    let quotesRow = QuotesRowController()
    let booksRow = BooksRowController()
    
    private let reusableTableViewCellID = "CollectionViewTableViewCell"
    private let reusableCollectionViewCellID = "CollectionViewCell"
    
    enum TableRow: Int, CaseIterable {
        case videos
        case quotes
        case books
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        title = iDadViewModel?.name
        
        configureIDadProfileHeaderView()
        reloadRowControllersData()
    }
    
    func configureIDadProfileHeaderView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: view.frame.height/3.3))
        if USE_LOCAL_DATA {
            imageView.image = iDadViewModel.landscapePicture
        } else {
            imageView.imageFromURL(iDadViewModel.imageURLs[1])
        }
        imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = imageView
    }
    
    func reloadRowControllersData() {
        videosRow.videoRequests = iDadViewModel.videoRequests
        quotesRow.quotes = iDadViewModel.quotes
        booksRow.books = iDadViewModel.books
    }
    
//MARK: tableView
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = TableRow(rawValue: indexPath.row) else {
            return 140
        }
        switch row {
        case .videos:
            return videosRow.heightForRow()
        case .quotes:
            return quotesRow.heightForRow()
        case .books:
            return booksRow.heightForRow()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? TableRow.allCases.count : 0
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
        
        guard let row = TableRow(rawValue: collectionView.tag) else {
            return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        }
        
        switch row {
        case .videos:
            return videosRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        case .quotes:
            return quotesRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        case .books:
            return booksRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        }
    }
}

extension IDadProfileTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let row = TableRow(rawValue: collectionView.tag) else {
            return 0
        }
        
        switch row {
        case .videos:
            return videosRow.numberOfItemsInSection(section: section)
        case .quotes:
            return quotesRow.numberOfItemsInSection(section: section)
        case .books:
            return booksRow.numberOfItemsInSection(section: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let row = TableRow(rawValue: collectionView.tag) else {
            return UICollectionViewCell()
        }
        
        switch row {
        case .videos:
            return videosRow.cell(collectionView: collectionView, indexPath: indexPath)
        case .quotes:
            return quotesRow.cell(collectionView: collectionView, indexPath: indexPath)
        case .books:
            return booksRow.cell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard .books == TableRow(rawValue: collectionView.tag) else { return }
        
        booksRow.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return TableRow(rawValue: collectionView.tag) == .books ? true : false
    }
}
