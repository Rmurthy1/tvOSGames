//
//  ClassifiedCollectionViewCell.swift
//  tvOSGames
//
//  Created by Rahul Murthy on 2/27/22.
//

import UIKit

class ClassifiedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.size.height/2 // square to round
        containerView.clipsToBounds = true
        containerView.backgroundColor = .random
        containerView.layer.borderWidth = 10
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configureView(text: String) {
        containerView.backgroundColor = UIColor.random
        titleLabel.text = text
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            containerView.layer.borderColor = UIColor.white.cgColor
            titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
            containerView.layer.borderColor = UIColor.clear.cgColor
            titleLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.65...1),
                       green: .random(in: 0.65...1),
                       blue: .random(in: 0.65...1),
                       alpha: 0.8)
    }
}
