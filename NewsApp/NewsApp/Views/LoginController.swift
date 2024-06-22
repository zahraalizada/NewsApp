//
//  LoginController.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginVM = LoginViewModel()
    var registerVM = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    @IBAction func skipTappedButton(_ sender: Any) {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.setTabBarAsRoot()
        }
    }
    @IBAction func signInTappedButton(_ sender: Any) {
        
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        if emailField.text == "",
           passwordField.text == "" {
            errorLabel.text = "Zəhmət olmasa bütün boş xanaları doldurun."
            errorLabel.isHidden = false
        } else {
            if loginVM.manager.isValidEmail(email: emailField.text ?? ""){
                
                loginVM.manager.getUsers { users in
                    if users.contains(where:  {$0.email == email && $0.password == password}) {
                        UserDefaults.standard.setValue(email, forKey: "email")
                        DispatchQueue.main.async {
                            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                                sceneDelegate.setTabBarAsRoot()
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = "Daxil etdiyiniz e-mail və ya şifrə yanlışdır."
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Daxil etdiyiniz e-mail formatı yanlışdır."
                }
            }
        }
    }
    
    @IBAction func registerTappedButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(RegisterController.self)") as! RegisterController
        
        controller.registerVM.userCallback = { [weak self] user in
            self?.loginVM.user = user
            self?.emailField.text = user.email
            self?.passwordField.text = user.password
        }
        
        navigationController?.show(controller, sender: nil)
        errorLabel.isHidden = true
    }
}
