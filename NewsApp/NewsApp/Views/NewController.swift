//
//  NewController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 24.06.24.
//

import UIKit

class NewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToLoginTapped(_ sender: Any) {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.setLoginAsRoot()
        }
    }
}
