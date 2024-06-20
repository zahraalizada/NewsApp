//
//  PostManager.swift
//  NewsApp
//
//  Created by Zahra Alizada on 19.06.24.
//

import Foundation

class PostManager {
    
    func parsePostsFile() -> [Post] {
            var posts = [Post]()
            if let file = Bundle.main.url(forResource: "Posts", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: file)
                    posts = try JSONDecoder().decode([Post].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            return posts
        }
}
