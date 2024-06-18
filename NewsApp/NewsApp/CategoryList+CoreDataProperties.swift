//
//  CategoryList+CoreDataProperties.swift
//  NewsApp
//
//  Created by Zahra Alizada on 18.06.24.
//
//

import Foundation
import CoreData


extension CategoryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryList> {
        return NSFetchRequest<CategoryList>(entityName: "CategoryList")
    }


}

extension CategoryList : Identifiable {

}
