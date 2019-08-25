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
    
    let videosRow = VideosRowController()
    let quotesRow = QuotesRowController()
    let booksRow = BooksRowController()
    
    private let reusableTableViewCellID = "CollectionViewTableViewCell"
    private let reusableCollectionViewCellID = "CollectionViewCell"
    
    enum ContentRow: Int, CaseIterable {
        case videos
        case quotes
        case books
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        title = iDadViewModel?.name
        
        configureIDadProfileHeaderView()
    }
    
    func configureIDadProfileHeaderView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: view.frame.height/3.3))
        imageView.image = iDadViewModel.landscapePicture
        imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = imageView
    }
    
//MARK: tableView
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = ContentRow(rawValue: indexPath.row) else {
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
        return section == 0 ? ContentRow.allCases.count : 0
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
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return 0
        }
        
        switch row {
        case .videos:
            return videosRow.numberOfItemsInSection(section: section, videos: iDadViewModel.videoRequests)
        case .quotes:
            return quotesRow.numberOfItemsInSection(section: section, quotes: iDadViewModel.quotes)
        case .books:
            return booksRow.numberOfItemsInSection(section: section, books: iDadViewModel.books)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return UICollectionViewCell()
        }
        
        switch row {
        case .videos:
            return videosRow.cell(collectionView: collectionView, indexPath: indexPath, videoRequests: iDadViewModel.videoRequests)
        case .quotes:
            return quotesRow.cell(collectionView: collectionView, indexPath: indexPath, quotes: iDadViewModel.quotes)
        case .books:
            return booksRow.cell(collectionView: collectionView, indexPath: indexPath, books: iDadViewModel.books)
        }
        
    }
}
