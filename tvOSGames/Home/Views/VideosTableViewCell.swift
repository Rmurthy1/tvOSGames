//
//  VideosTableViewCell.swift
//  tvOSGames
//
//  Created by Rahul Murthy on 3/2/22.
//

import UIKit

protocol VideosCollectionViewCellDelegate: AnyObject {
    func didSelectItem()
}
/// tableview cell that contains a collectionview of videos
class VideosTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionViewHeightConstraint: NSLayoutConstraint!
    
    // dummy data (imagenames)
    var latestVideos = ["R","A","H","U","L"]
    var carousalVideos = ["R", "A"]
    var classifiedVideos = ["This", "is only", "a test", "program"]
    var toolsVideos = ["R", "H", "L"]
    
    var cellType: CellType = .latestVideos
    weak var delegate: VideosCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNibs()
        videosCollectionView.dataSource = self
        videosCollectionView.delegate = self
    }
    
    func registerNibs() {
        let videoName = "VideosCollectionViewCell"
        let classifiedName = "ClassifiedCollectionViewCell"
        let toolsName = "ToolsCollectionViewCell"
        videosCollectionView.register(UINib(nibName: videoName, bundle: nil), forCellWithReuseIdentifier: videoName)
        videosCollectionView.register(UINib(nibName: classifiedName, bundle: nil), forCellWithReuseIdentifier: classifiedName)
        videosCollectionView.register(UINib(nibName: toolsName, bundle: nil), forCellWithReuseIdentifier: toolsName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .carousal:
            return CGSize(width: collectionView.frame.size.width / 1.25, height: collectionView.frame.size.height)
        case .latestVideos, .tools:
            return CGSize(width: (16/9) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        case .classified:
            return CGSize(width: 360, height: 360)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .carousal:
            return carousalVideos.count
        case .latestVideos:
            return latestVideos.count
        case .classified:
            return classifiedVideos.count
        case .tools:
            return toolsVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType {
        case .carousal:
            if let cell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell {
                cell.type = cellType
                cell.posterImageView.image = UIImage(named: carousalVideos[indexPath.row])
                cell.posterImageView.contentMode = .scaleAspectFill
                return cell
            }
            return UICollectionViewCell()
        case .latestVideos:
            if let cell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell {
                cell.type = cellType
                cell.posterImageView.image = UIImage(named: latestVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
            
        case .classified:
            if let cell: ClassifiedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassifiedCollectionViewCell", for: indexPath) as? ClassifiedCollectionViewCell {
                cell.configureView(text: classifiedVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
            
        case .tools:
            if let cell: ToolsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolsCollectionViewCell", for: indexPath) as? ToolsCollectionViewCell {
                cell.posterImageView.image = UIImage(named: toolsVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        }
    }
}
