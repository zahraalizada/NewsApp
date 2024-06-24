//
//  FavoriteCell.swift
//  NewsApp
//
//  Created by Zahra Alizada on 22.06.24.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak private var postDate: UILabel!
    @IBOutlet weak private var postTitle: UILabel!
    @IBOutlet weak private var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String, image: String, date: String) {
        postTitle.text = title
        postDate.text = date
        postImage.image = UIImage(named: image)
    }
    
}
