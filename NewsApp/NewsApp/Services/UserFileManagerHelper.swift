//
//  UserFileManagerHelper.swift
//  NewsApp
//
//  Created by Zahra Alizada on 05.06.24.
//

import Foundation

class UserFileManagerHelper {
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("Users.json")
        print(path)
        return path
    }
    
    func saveUser(data: [User]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUsers(complete: (([User]) -> Void)) {
        let path = getFilePath()
        if FileManager.default.fileExists(atPath: path.path) {
            if let data = try? Data(contentsOf: path) {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    complete(users)
                } catch {
                    print(error.localizedDescription)
                    complete([])
                }
            } else {
                complete([])
            }
        } else {
            complete([])
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
