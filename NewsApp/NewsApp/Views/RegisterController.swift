//
//  RegisterController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var registerVM = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        errorLabel.isHidden = true
    }
    
    @IBAction func signupTappedButton(_ sender: Any) {
        guard let fullname = fullnameField.text, !fullname.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            errorLabel.text = "Zəhmət olmasa bütün boş xanaları doldurun."
            errorLabel.isHidden = false
            return
        }
        
        if registerVM.manager.isValidEmail(email: email) {
            UserDefaults.standard.setValue(true, forKey: "userRegistered")
            
            let user = User(fullname: fullname, email: email, password: password)
            
            registerVM.manager.getUsers { users in
                var updatedUsers = users
                updatedUsers.append(user)
                self.registerVM.manager.saveUser(data: updatedUsers)
                self.registerVM.userCallback?(user)
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            errorLabel.text = "Zəhmət olmasa düzgün email daxil edin."
            errorLabel.isHidden = false
        }
    }
}
