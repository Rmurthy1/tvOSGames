//
//  HomeViewController.swift
//  tvOSGames
//
//  Created by Rahul Murthy on 2/27/22.
//

import UIKit

enum CellType: Int, CaseIterable {
    case carousal
    case latestVideos
    case classified
    case tools
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        homeDataTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        homeDataTableView.estimatedRowHeight = 300
        homeDataTableView.rowHeight = UITableView.automaticDimension
        homeDataTableView.delegate = self
        homeDataTableView.dataSource = self
        homeDataTableView.reloadData()

    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as? VideosTableViewCell, let cellType = CellType(rawValue: indexPath.row) {
            cell.cellType = cellType
            switch cellType {
            case .carousal:
                    cell.titleLabel.isHidden = true
                    cell.videosCollectionViewHeightConstraint.constant = 540
            case .latestVideos:
                    cell.titleLabel.text = "These buttons work"
                    cell.videosCollectionViewHeightConstraint.constant = 360
                    cell.delegate = self
            case .classified:
                    cell.titleLabel.text = "These buttons do not work"
                    cell.videosCollectionViewHeightConstraint.constant = 360
                    cell.videosCollectionView.reloadData()
            case .tools:
                    cell.titleLabel.text = "Parallax images"
                    cell.videosCollectionViewHeightConstraint.constant = 300
                    cell.videosCollectionView.reloadData()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension HomeViewController: VideosCollectionViewCellDelegate {

    func didSelectItem() {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
