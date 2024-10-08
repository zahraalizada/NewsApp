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
    @IBOutlet weak var searchStackView: UIStackView!
    
    let postManager = PostManager()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViewDidLoad()
    }
    
    func setupViewDidLoad() {
        searchCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        searchCollectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        posts = postManager.parsePostsFile()
        setupSearchStackView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteStatusChanged), name: NSNotification.Name("FavoriteStatusChanged"), object: nil)
    }
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        if let headerView = searchCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as? HeaderView {
            headerView.selectedCategoryIndex = -1
        }
        posts = postManager.filterPostsWithSearch(text: searchField.text ?? "")
        searchCollectionView.reloadData()
    }
    
    @objc func handleFavoriteStatusChanged(notification: NSNotification) {
        posts = postManager.parsePostsFile()
        searchCollectionView.reloadData()
    }
    
    private func setupSearchStackView() {
        searchStackView.layer.borderColor = UIColor(red: 75.0 / 255.0, green: 45.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0).cgColor
        searchStackView.layer.borderWidth = 1.0
        searchStackView.isLayoutMarginsRelativeArrangement = true
        searchStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.item]
        cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "", content: "")
        
        let favoriteImage = post.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.favoriteButton.setImage(favoriteImage, for: .normal)
        
        cell.favoriteButtonAction = { [weak self] in
            guard let self = self else { return }
            self.toggleFavorite(at: indexPath)
            collectionView.reloadData()
        }
        return cell
    }
    
    private func toggleFavorite(at indexPath: IndexPath) {
        posts[indexPath.item].isFavorite.toggle()
        postManager.updatePost(posts[indexPath.item])
        searchCollectionView.reloadItems(at: [indexPath])
        NotificationCenter.default.post(name: NSNotification.Name("FavoriteStatusChanged"), object: nil)
    }
}

extension SearchController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(PostDetailController.self)") as! PostDetailController
        controller.post = posts[indexPath.row]
        navigationController?.show(controller, sender: nil)
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        
        header.onCategorySelected = { [weak self] category in
            guard let self = self else { return }
            if let category = category {
                self.posts = self.postManager.filterPosts(by: category.name ?? "")
            } else {
                self.posts = self.postManager.parsePostsFile()
            }
            self.searchCollectionView.reloadData()
        }
        return header
    }
}
