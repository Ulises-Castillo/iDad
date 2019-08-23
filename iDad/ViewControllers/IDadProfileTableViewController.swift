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
    
    private let reusableTableViewCellID = "CollectionViewTableViewCell"
    private let reusableCollectionViewCellID = "CollectionViewCell"
    
    enum ContentRow: Int, CaseIterable {
        case videos // "= 0" not required - first case starts at zero by default
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
        guard iDadViewModel.photos.count > 1 else {
            return
        }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: view.frame.height/3.3))
        imageView.image = iDadViewModel.photos[1]
        imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = imageView
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
        case ContentRow.books:
            return BooksRow.heightForRow()
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
        case ContentRow.videos:
            return VideosRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        case ContentRow.quotes:
            return QuotesRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        case ContentRow.books:
            return BooksRow.sizeForItem(indexPath: indexPath, viewFrame: view.frame.size)
        }
    }
}

extension IDadProfileTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return 0
        }
        
        switch row {
        case ContentRow.videos:
            return VideosRow.numberOfItemsInSection(section: section, videos: iDadViewModel.videos)
        case ContentRow.quotes:
            return QuotesRow.numberOfItemsInSection(section: section, quotes: iDadViewModel.quotes)
        case ContentRow.books:
            return BooksRow.numberOfItemsInSection(section: section, books: iDadViewModel.books)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return UICollectionViewCell()
        }
        
        switch row {
        case ContentRow.videos:
            return VideosRow.cell(collectionView: collectionView, indexPath: indexPath, videos: iDadViewModel.videos)
        case ContentRow.quotes:
            return QuotesRow.cell(collectionView: collectionView, indexPath: indexPath, quotes: iDadViewModel.quotes)
        case ContentRow.books:
            return BooksRow.cell(collectionView: collectionView, indexPath: indexPath, books: iDadViewModel.books)
        }
        
    }
}
