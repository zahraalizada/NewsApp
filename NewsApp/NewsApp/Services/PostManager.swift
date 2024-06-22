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
    
    func filterPostsWithSearch(text: String) -> [Post] {
        let posts = parsePostsFile()
        if text.isEmpty {
            return posts
        } else {
            return posts.filter { post in
                return post.title?.lowercased().contains(text.lowercased()) ?? false
            }
        }
    }
    
    func filterPosts(by categoryName: String) -> [Post] {
        let posts = parsePostsFile()
        return posts.filter { post in
            return post.categoryName == categoryName
        }
    }
    
    func getSliderPosts(posts: [Post]) -> [Post] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let sortedPosts = posts.compactMap { post -> (Post, Date)? in
            if let dateString = post.date, let date = dateFormatter.date(from: dateString) {
                return (post, date)
            }
            return nil
        }.sorted(by: { $0.1 > $1.1 })
        
        return sortedPosts.prefix(10).map { $0.0 }
    }
    
    func filterFavoritePosts() -> [Post] {
        let posts = parsePostsFile()
        return posts.filter { $0.isFavorite }
    }
    
    func updatePost(_ post: Post) {
        var allPosts = parsePostsFile() 
        
        if let index = allPosts.firstIndex(where: { $0.title == post.title }) {
            allPosts[index] = post
            savePostsToFile(posts: allPosts)
        }
    }
    
    private func savePostsToFile(posts: [Post]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted  // Opsiyonel: JSON dosyasını okunabilir formatta kaydetmek için
        
        if let url = Bundle.main.url(forResource: "Posts", withExtension: "json") {
            do {
                let data = try encoder.encode(posts)
                try data.write(to: url)
            } catch {
                print("Error saving posts to file: \(error.localizedDescription)")
            }
        }
    }
    
    
}
