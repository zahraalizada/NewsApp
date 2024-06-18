//
//  CategoryCell.swift
//  NewsApp
//
//  Created by Zahra Alizada on 18.06.24.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak private var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(name: String) {
        categoryNameLabel.text = name
    }
}
