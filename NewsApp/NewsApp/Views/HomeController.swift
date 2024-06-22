//
//  HomeController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    let postManager = PostManager()
    var posts = [Post]()
    var allPosts = [Post]()
    var sliderPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        topCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        bottomCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        bottomCollectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        allPosts = postManager.parsePostsFile()
        
        posts = postManager.parsePostsFile()
        sliderPosts = postManager.getSliderPosts(posts: posts)
        
        topCollectionView.reloadData()
        bottomCollectionView.reloadData()
    }
    
    @IBAction func allNewsTappedButton(_ sender: Any) {
        posts = allPosts
        bottomCollectionView.reloadData()
    }
    
}


extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCollectionView:
            return sliderPosts.count
        case bottomCollectionView:
            return posts.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case topCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            let post = sliderPosts[indexPath.item]
            print(post)
            cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "")
            cell.favoriteButton.isHidden = true
            return cell
            
        case bottomCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            let post = posts[indexPath.item]
            cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "")
            cell.favoriteButton.isHidden = true
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeController: UICollectionViewDelegate {
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView {
            return CGSize(width: collectionView.frame.width - 10, height: 170)
        } else if collectionView == bottomCollectionView {
            return CGSize(width: collectionView.frame.width - 20, height: 170)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch collectionView {
        case bottomCollectionView:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            header.onCategorySelected = { [weak self] category in
                guard let self = self else { return }
                self.posts = self.postManager.filterPosts(by: category.name ?? "")
                self.bottomCollectionView.reloadData()
            }
            return header
        default:
            return HeaderView()
        }
    }
}
