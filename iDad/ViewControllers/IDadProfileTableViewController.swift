//
//  IDadProfileViewController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadProfileTableViewController: UITableViewController {

    var iDadViewModel: IDadViewModel? = nil
    let model: [[UIColor]] = Utils.generateRandomColor2DArray()
    var collectionViewsStoredOffsets = [Int: CGFloat]()
    
    private let reusableTableViewCellID = "CollectionViewTableViewCell"
    private let reusableCollectionViewCellID = "CollectionViewCell"
    
    enum ContentRow: Int {
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
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? model.count : 0
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

extension IDadProfileTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let row = ContentRow(rawValue: collectionView.tag) else {
            return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        }
        
        switch row {
        case ContentRow.videos:
            return VideoRow.sizeForItem(indexPath: indexPath, viewFrame: view?.frame.size ?? CGSize(width: 300, height: 800))
        default:
            return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        }
    }
}

extension IDadProfileTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case ContentRow.videos.rawValue:
            return VideoRow.numberOfItemsInSection(section: section)
        default:
            return section == 0 ? model[collectionView.tag].count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case ContentRow.videos.rawValue:
            return VideoRow.cell(collectionView: collectionView, indexPath: indexPath)
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCollectionViewCellID, for: indexPath)
            cell.backgroundColor = model[collectionView.tag][indexPath.item]
            return cell
        }
        
    }
}

struct VideoRow {
    static private let reusableVideoCollectionViewCellID = "VideoCollectionViewCell"
    
    static func cell(collectionView: UICollectionView, indexPath: IndexPath) -> VideoCollectionViewCell {
        let nib = UINib(nibName: reusableVideoCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableVideoCollectionViewCellID)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableVideoCollectionViewCellID, for: indexPath) as! VideoCollectionViewCell //TODO: remove !
        
        let videoURL = URL(string: "https://www.youtube.com/embed/5ER1LOarlgg")! //TODO: remove !
        
        
        let requestObj = URLRequest(url: videoURL)
        cell.webView.load(requestObj)
        
        return cell
    }
    
    static func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
        return CGSize(width: viewFrame.width / 3, height: viewFrame.width / 3)
    }
    
    static func numberOfItemsInSection(section: Int) -> Int {
        return section == 0 ? 3 : 0
    }
}
