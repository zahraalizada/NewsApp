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
        filterPosts(text: searchField.text ?? "")
    }
    
    @IBAction func searchTappedButton(_ sender: Any) {
    }
    
    func filterPosts(text: String) {
        if text.isEmpty {
            // search-de text olmadiqda butun postlari goster
            posts = postManager.parsePostsFile()
        } else {
            //search-de text olduqda title ile filter et
            posts = postManager.parsePostsFile().filter { post in
                return post.title?.lowercased().contains(text.lowercased()) ?? false
            }
        }
        searchCollectionView.reloadData()
    }
    
    // CategoryName-e gore filter
       func filterPosts(by categoryName: String) {
           posts = postManager.parsePostsFile().filter { post in
               return post.categoryName == categoryName
           }
           searchCollectionView.reloadData()
       }
    
}

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.item]
        cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "")
        return cell
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
            self?.filterPosts(by: category.name ?? "")
        }
        
        return header
    }
}
