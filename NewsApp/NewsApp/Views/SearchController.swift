//
//  SearchController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    var items = [CategoryList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        fetchItems()
    }
    
    func fetchItems() {
        do {
            self.items = try context.fetch(CategoryList.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    

}
