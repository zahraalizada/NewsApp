//
//  RegisterViewModel.swift
//  NewsApp
//
//  Created by Zahra Alizada on 01.06.24.
//

import UIKit

class RegisterViewModel {
    var manager = UserFileManagerHelper()
    var userCallback: ((User) -> Void)?
    var users = [User]()
    
    func setAllTextFieldsUi(fullnameField: UITextField, emailField: UITextField, passwordField: UITextField) {
        setTextFieldUi(textField: fullnameField, placeholder: "Full Name")
        setTextFieldUi(textField: emailField, placeholder: "Email")
        setTextFieldUi(textField: passwordField, placeholder: "Password")
    }
    
    private func setTextFieldUi(textField: UITextField, placeholder: String) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        
        textField.layer.borderColor = UIColor(red: 75.0 / 255.0, green: 45.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1.0
        
        let placeholderColor = UIColor.gray
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
}
