//
//  PostCell.swift
//  NewsApp
//
//  Created by Zahra Alizada on 08.06.24.
//

import UIKit

class PostCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak private var postImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    var favoriteButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func favoriteTappedButon(_ sender: Any) {
        favoriteButtonAction?() 
    }
    
    func configure(image: String, title: String, date: String) {
        postImage.image = UIImage(named: image)
        titleLabel.text = title
        dateLabel.text = date
    }

}
