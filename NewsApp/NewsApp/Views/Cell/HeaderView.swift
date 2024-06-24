//
//  HeaderView.swift
//  NewsApp
//
//  Created by Zahra Alizada on 18.06.24.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    var viewModel = HeaderViewModel()
    var onCategorySelected: ((CategoryList) -> Void)?
    
    var selectedCategoryIndex: Int = -1 {
        didSet {
            headerCollectionView.reloadItems(at: [IndexPath(item: oldValue, section: 0), IndexPath(item: selectedCategoryIndex, section: 0)])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDidLoad()
    }
    
    func setupDidLoad() {
        headerCollectionView.dataSource = self
        headerCollectionView.delegate = self
        headerCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        viewModel.saveItemsIfNeeded()
        viewModel.items = viewModel.fetchItems()
    }
}

extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = viewModel.items[indexPath.item]
        cell.configure(name: category.name ?? "")
        cell.categoryNameLabel.textColor = indexPath.item == selectedCategoryIndex ? .white : UIColor(red: 75/255, green: 45/255, blue: 35/255, alpha: 1.0)
        cell.backgroundColor = indexPath.item == selectedCategoryIndex ? UIColor(red: 211/255, green: 94/255, blue: 58/255, alpha: 1.0) : .clear
        return cell
    }
}

extension HeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.item
        let selectedCategory = viewModel.items[indexPath.item]
        onCategorySelected?(selectedCategory)
    }
}

extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.2 - 20, height: 40)
    }
}

