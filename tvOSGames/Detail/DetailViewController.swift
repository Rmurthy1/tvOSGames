//
//  DetailViewController.swift
//  tvOSGames
//
//  Created by Rahul Murthy on 2/27/22.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    @IBOutlet weak var similarTableView: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "this is a description of the thing you are about to watch, be sure to look at the metadata! The favorites button does nothing at the moment and this is just dummy data! These are some shrimp."
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Cool Shrimp!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        similarTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        similarTableView.dataSource = self
        similarTableView.delegate = self
        similarTableView.estimatedRowHeight = 300
        similarTableView.rowHeight = UITableView.automaticDimension
        similarTableView.reloadData()
    }

    @IBAction func didClickOnPlayButton(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "IMG_0194", ofType: "mov") else {
            debugPrint("debug video not found! see play button on the detail view controller")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        let metaData = Metadata(title: "Shrimp Video", subtitle: "video of berried shrimp", description: "These shrimp are feeding and one female is carrying eggs, this is known as a berried shrimp", rating: "Really cool", genre: "Animals")
        playerController.player?.currentItem?.externalMetadata = createMetadataItems(for: metaData)
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    struct Metadata {
        var title = "unset title"
        var subtitle = "unset subtitle"
        var image = "debugging"
        var description = """
        unset description
        """
        var rating = "unset rating"
        var genre = "Education"
        init(title: String, subtitle: String = "unset subtitle", image: String = "debugging", description: String = "unset description", rating: String = "unset rating", genre: String = "Education") {
            self.title = title
            self.subtitle = subtitle
            self.image = image
            self.description = description
            self.rating = rating
            self.genre = genre
        }
    }
    
    func createMetadataItems(for metadata: Metadata) -> [AVMetadataItem] {
        let mapping: [AVMetadataIdentifier: Any] = [
            .commonIdentifierTitle: metadata.title,
            .iTunesMetadataTrackSubTitle: metadata.subtitle,
            .commonIdentifierArtwork: UIImage(named: metadata.image)?.pngData() as Any,
            .commonIdentifierDescription: metadata.description,
            .iTunesMetadataContentRating: metadata.rating,
            .quickTimeMetadataGenre: metadata.genre
        ]
        return mapping.compactMap { createMetadataItem(for:$0, value:$1) }
    }

    private func createMetadataItem(for identifier: AVMetadataIdentifier,
                                    value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        // Specify "und" to indicate an undefined language.
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as? VideosTableViewCell {
            cell.cellType = .latestVideos
            cell.latestVideos.removeFirst()// why?
            cell.titleLabel.text = "You May Like"
            cell.videosCollectionViewHeightConstraint.constant = 200
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
