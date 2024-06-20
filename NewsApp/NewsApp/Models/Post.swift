//
//  Post.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import Foundation

struct Post: Codable {
    let categoryName: String?
    let title: String?
    let content: String?
    let image: String?
    let date: String?
    let author: String?
    var isFavorite: Bool
}
