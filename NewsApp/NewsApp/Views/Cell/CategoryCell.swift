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
        setupBorder()
    }
    
    func setupBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 75.0 / 255.0, green: 45.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0).cgColor
        self.layer.backgroundColor = UIColor(red: 211.0 / 255.0, green: 94.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0).cgColor
    }
    
    func configure(name: String,
                   fontColor: UIColor = UIColor(red: 75/255, green: 45/255, blue: 35/255, alpha: 1.0)) {
        categoryNameLabel.text = name
        categoryNameLabel.textColor = fontColor
    }
    
    override var isSelected: Bool {
        didSet {
            categoryNameLabel.textColor = isSelected ? .white : UIColor(red: 75/255, green: 45/255, blue: 35/255, alpha: 1.0)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
}
