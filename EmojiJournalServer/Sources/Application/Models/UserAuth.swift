//
//  UserAuth.swift
//  Application
//
//  Created by Patel, Virenkumar on 4/30/19.
//

import Foundation
import CredentialsHTTP

public struct UserAuth{
    public var id: String
    private var password: String
}

extension UserAuth: TypeSafeHTTPBasic {
    public static func verifyPassword(username: String, password: String, callback: @escaping (UserAuth?) -> Void) {
        if let storedPassword = authenticate[username], storedPassword == password {
            callback(UserAuth(id: username, password: password))
            return
        } else {
            callback(nil)
        }
    }
    
    public static let authenticate = ["John": "12345", "Mary": "ABCDE"]
}
