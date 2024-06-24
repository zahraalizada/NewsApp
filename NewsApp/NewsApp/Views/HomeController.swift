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
    
    let homeVM = HomeViewModel()
    var selectedCategoryIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewDidLoad()
    }
    
    func setViewDidLoad() {
        topCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        bottomCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        bottomCollectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        homeVM.allPosts = homeVM.postManager.parsePostsFile()
        homeVM.posts = homeVM.postManager.parsePostsFile()
        homeVM.sliderPosts = homeVM.postManager.getSliderPosts(posts: homeVM.posts)
        
        topCollectionView.reloadData()
        bottomCollectionView.reloadData()
        
        homeVM.setCollectionViewBorder(for: topCollectionView)
    }
    
    @IBAction func allNewsTappedButton(_ sender: Any) {
        homeVM.posts = homeVM.allPosts
        bottomCollectionView.reloadData()
    }
}


extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCollectionView:
            return homeVM.sliderPosts.count
        case bottomCollectionView:
            return homeVM.posts.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            let post = homeVM.sliderPosts[indexPath.item]
            print(post)
            cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "", content: "")
            cell.contentLabel.isHidden = true
            cell.favoriteButton.isHidden = true
            cell.borderView.isHidden = true
            return cell
            
        case bottomCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            let post = homeVM.posts[indexPath.item]
            cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "", content: post.content ?? "")
            cell.favoriteButton.isHidden = true
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeController: UICollectionViewDelegate {
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let headerView = bottomCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as? HeaderView {
            headerView.selectedCategoryIndex = indexPath.item
            selectedCategoryIndex = indexPath.item
            bottomCollectionView.reloadData()
        }
        
        if collectionView == topCollectionView {
            let controller = storyboard?.instantiateViewController(identifier: "\(PostDetailController.self)") as! PostDetailController
            controller.post = homeVM.sliderPosts[indexPath.row]
            navigationController?.show(controller, sender: nil)
        } else if collectionView == bottomCollectionView {
            let controller = storyboard?.instantiateViewController(identifier: "\(PostDetailController.self)") as! PostDetailController
            controller.post = homeVM.posts[indexPath.row]
            navigationController?.show(controller, sender: nil)
        }
        
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView {
            return CGSize(width: collectionView.frame.width - 16, height: 250)
        } else if collectionView == bottomCollectionView {
            return CGSize(width: collectionView.frame.width - 20, height: 300)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch collectionView {
        case bottomCollectionView:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            header.onCategorySelected = { [weak self] category in
                guard let self = self else { return }
                self.homeVM.posts = self.homeVM.postManager.filterPosts(by: category.name ?? "")
                self.bottomCollectionView.reloadData()
            }
            return header
        default:
            return HeaderView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == topCollectionView {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        
       
    }
  
}
