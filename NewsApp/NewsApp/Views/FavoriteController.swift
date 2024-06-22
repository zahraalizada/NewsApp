//
//  FavoriteController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class FavoriteController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let postManager = PostManager()
    var favoritePosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        
        table.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        
        favoritePosts = postManager.filterFavoritePosts()
        table.reloadData()
    }
    
    
}


extension FavoriteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteCell
        let post = favoritePosts[indexPath.row]
        cell.textLabel?.text = post.title
        //        cell.configure(image: post.image ?? "", title: post.title ?? "", date: post.date ?? "")
        return cell
    }
}

extension FavoriteController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedPost = favoritePosts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handlePostDeletion(post: removedPost)
        }
    }
    
    func handlePostDeletion(post: Post) {
       //  
    }
}


