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
        if fullnameField.text == "",
           emailField.text == "",
           passwordField.text == "" {
            errorLabel.text = "Zəhmət olmasa bütün boş xanaları doldurun."
            errorLabel.isHidden = false
        } else {
            if registerVM.manager.isValidEmail(email: emailField.text ?? "") {
                UserDefaults.standard.setValue(true, forKey: "userRegistered")
                
                let user = User(fullname: fullnameField.text,
                                email: emailField.text,
                                password: passwordField.text)
                
                registerVM.manager.getUsers { users in
                    registerVM.userCallback?(user)
                    var updatedUsers = users
                    updatedUsers.append(user)
                    self.registerVM.manager.saveUser(data: updatedUsers)
                }
                
                navigationController?.popViewController(animated: true)
            } else {
                errorLabel.text = "Zəhmət olmasa düzgün email daxil edin."
                errorLabel.isHidden = false
            }
        }
    }
}
