//
//  PostDetailController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class PostDetailController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDidLoad()
    }
    
    func setupDidLoad() {
        table.layer.borderWidth = 1.0
        table.layer.borderColor = UIColor(red: 75.0 / 255.0, green: 45.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0).cgColor
        table.separatorStyle = .none
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}

extension PostDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell") as! PostDetailCell
        cell.configure(title: post?.title ?? "",
                       image: post?.image ?? "",
                       date: post?.date ?? "",
                       author: "by \(post?.author ?? "")" ,
                       content: post?.content ?? "")
        return cell
    }
}

extension PostDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
}
