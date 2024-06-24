//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class HomeViewModel {
    
    let postManager = PostManager()
    var posts = [Post]()
    var allPosts = [Post]()
    var sliderPosts = [Post]()
    
    func setCollectionViewBorder(for collectionView: UICollectionView) {
        collectionView.layer.borderColor = UIColor(red: 75.0 / 255.0, green: 45.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0).cgColor
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.shadowColor = UIColor.gray.cgColor
        collectionView.layer.shadowOpacity = 0.8
        collectionView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        collectionView.layer.shadowRadius = 4.0
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}
