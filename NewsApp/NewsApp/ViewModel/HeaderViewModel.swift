//
//  HeaderViewModel.swift
//  NewsApp
//
//  Created by Zahra Alizada on 20.06.24.
//

import Foundation
import UIKit
import CoreData


class HeaderViewModel {
    var items = [CategoryList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveItemsIfNeeded() {
        let savedItems = fetchItems()
        if savedItems.isEmpty {
            saveItem(text: "Politics")
            saveItem(text: "Business")
            saveItem(text: "Technology")
            saveItem(text: "Entertainment")
            saveItem(text: "Sports")
            saveItem(text: "Health")
            saveItem(text: "Science")
            saveItem(text: "Education")
            saveItem(text: "Travel")
        }
    }
    
    private func saveItem(text: String) {
        do {
            let model = CategoryList(context: context)
            model.name = text
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchItems() -> [CategoryList] {
        do {
            self.items = try context.fetch(CategoryList.fetchRequest())
            return self.items
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
