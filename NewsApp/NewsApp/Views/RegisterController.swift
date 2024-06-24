//
//  RegisterController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var registerVM = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewDidLoad()
    }
    
    func setViewDidLoad() {
        errorLabel.isHidden = true
        fullnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        registerVM.setAllTextFieldsUi(fullnameField: fullnameField, emailField: emailField, passwordField: passwordField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 210.0 / 255.0, green: 90.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 75.0 / 255.0, green: 45.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0).cgColor
    }
    
    @IBAction func signupTappedButton(_ sender: Any) {
        guard let fullname = fullnameField.text, !fullname.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            errorLabel.text = "Please fill in all empty fields."
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
            errorLabel.text = "The email format you entered is incorrect."
            errorLabel.isHidden = false
        }
    }
}
