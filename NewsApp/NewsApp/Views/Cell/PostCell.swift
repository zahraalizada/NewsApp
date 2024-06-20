//
//  PostCell.swift
//  NewsApp
//
//  Created by Zahra Alizada on 08.06.24.
//

import UIKit

class PostCell: UICollectionViewCell {

    @IBOutlet weak private var postImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: String, title: String) {
        postImage.image = UIImage(named: image)
        titleLabel.text = title
    }

}
