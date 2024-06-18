//
//  HeaderView.swift
//  NewsApp
//
//  Created by Zahra Alizada on 18.06.24.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    var items = [CategoryList]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerCollectionView.dataSource = self
        headerCollectionView.delegate = self
        headerCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        
        saveItem(text: "News")
        saveItem(text: "Animal")
        saveItem(text: "Geography")
        saveItem(text: "Bbc news")
        saveItem(text: "Football")
        saveItem(text: "Volleyball")
        saveItem(text: "Basketball")
        saveItem(text: "Tecnology")
        fetchItems()
    }
    
    func saveItem(text: String) {
        do {
            let model = CategoryList(context: context)
            model.name = text
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchItems() {
        do {
            self.items = try context.fetch(CategoryList.fetchRequest())
            print(items)
        } catch {
            print(error.localizedDescription)
        }
    }

 
    
}

extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.backgroundColor = .systemCyan
        let category = items[indexPath.item]
        cell.configure(name: category.name ?? "")
        return cell
    }
    
    
}

extension HeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
}

extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/3 - 20, height: 40)
    }
}
