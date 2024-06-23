//
//  PostDetailController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class PostDetailController: UIViewController {
    
//    @IBOutlet weak var table: UITableView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var postImage: UIImageView!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var authorLabel: UILabel!
//    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Detail"
        
    }
    

}

extension PostDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell", for: indexPath)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell", for: indexPath)
//        return cell
//    }
    
}

extension PostDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
