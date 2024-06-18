//
//  ProfileController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var profileVM = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        addLogoutBtn()
        getUserDetails()
    }
    
    func addLogoutBtn() {
        let powerIcon = UIImage(systemName: "power")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)
        let logoutBtn = UIBarButtonItem(image: powerIcon, style: .plain, target: self, action: #selector(logoutTappedButton(_:)))
        navigationItem.rightBarButtonItem = logoutBtn
    }
    
    func getUserDetails() {
        if let savedEmail = UserDefaults.standard.string(forKey: "email") {
            profileVM.manager.getUsers { users in
                let userIndex = users.firstIndex(where: {$0.email == savedEmail})
                fullnameLabel.text = users[userIndex!].fullname
                emailLabel.text = users[userIndex!].email
                passwordLabel.text = users[userIndex!].password
            }
        } else {
            print("-- Email not found --")
        }
    }
    
    @IBAction func logoutTappedButton(_ sender: Any) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.setLoginAsRoot()
        }
    }
}
