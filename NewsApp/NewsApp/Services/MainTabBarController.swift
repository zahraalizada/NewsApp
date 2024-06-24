//
//  MainTabBarController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 24.06.24.
//
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let viewControllers = tabBarController.viewControllers,
           let index = viewControllers.firstIndex(of: viewController) {
            if index == 3 || index == 2{
                let isLoggedIn = UserDefaults.standard.bool(forKey: "userRegistered")
                if !isLoggedIn {
                    if let newController = storyboard?.instantiateViewController(withIdentifier: "NewController") {
                        present(newController, animated: true, completion: nil)
                        return false
                    }
                }
            }
        }
        return true
    }
}
