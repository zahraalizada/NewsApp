//
//  SearchController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 18.06.24.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    
    let postManager = PostManager()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        searchCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        searchCollectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        posts = postManager.parsePostsFile()
    }
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        posts = postManager.filterPostsWithSearch(text: searchField.text ?? "")
        searchCollectionView.reloadData()
    }
    
    @IBAction func searchTappedButton(_ sender: Any) {
    }
}

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        var post = posts[indexPath.item]
        cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "")
        
        
        let favoriteImage = post.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.favoriteButton.setImage(favoriteImage, for: .normal)
        
        
        cell.favoriteButtonAction = { [weak self] in
            guard let self = self else { return }
            self.toggleFavorite(for: &post)
            collectionView.reloadData()
        }
        
        return cell
    }
    
    private func toggleFavorite(for post: inout Post) {
        post.isFavorite.toggle() // Favori durumu toggle et
        
        // JSON dosyasında güncelleme yapılabilir (opsiyonel)
        postManager.updatePost(post) // PostManager'da updatePost metodunu çağırarak güncelleme yapılabilir
    }
    
}

extension SearchController: UICollectionViewDelegate {
    
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 20, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        
        // HeaderView-daki clsoure-i define et
        header.onCategorySelected = { [weak self] category in
            guard let self = self else { return }
            self.posts = self.postManager.filterPosts(by: category.name ?? "")
            self.searchCollectionView.reloadData()
        }
        
        return header
    }
}
