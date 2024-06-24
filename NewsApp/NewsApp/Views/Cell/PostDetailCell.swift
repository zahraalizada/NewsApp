//
//  PostDetailCell.swift
//  NewsApp
//
//  Created by Zahra Alizada on 24.06.24.
//

import UIKit

class PostDetailCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var postImage: UIImageView!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String, image: String, date: String, author: String, content: String) {
        titleLabel.text = title
        dateLabel.text = date
        authorLabel.text = author
        contentLabel.text = content
        postImage.image = UIImage(named: image)
    }
}
