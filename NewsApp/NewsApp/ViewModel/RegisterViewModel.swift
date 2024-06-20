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
}
