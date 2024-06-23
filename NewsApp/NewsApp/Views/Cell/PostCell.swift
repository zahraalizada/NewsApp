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
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var borderView: UIView!
    
    var favoriteButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func favoriteTappedButon(_ sender: Any) {
        favoriteButtonAction?() 
    }
    
    func configure(image: String, title: String, date: String, content: String) {
        postImage.image = UIImage(named: image)
        titleLabel.text = title
        dateLabel.text = date
        contentLabel.text = content
    }

}
