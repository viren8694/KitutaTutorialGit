//
//  UserRoutes.swift
//  Application
//
//  Created by Patel, Virenkumar on 5/1/19.
//

import Foundation
import LoggerAPI
import Kitura

func initializeUserRoutes(app: App) {
    app.router.post("/user", handler: addUser)
    app.router.delete("/user", handler: deleteUser)
    app.router.get("/user", handler: getAllUsers)
    Log.info("User Routes Created.")
}

func addUser(user: UserAuth, completion: @escaping (UserAuth?, RequestError?) -> Void) {
    user.save(completion)
}

func deleteUser(user: UserAuth, id: String, completion: @escaping (RequestError?) -> Void) {
    if user.id != id {
        completion(RequestError.forbidden)
    } else {
        UserAuth.delete(id: id, completion)
    }
}

func getAllUsers(completion: @escaping ([UserAuth]?, RequestError? ) -> Void) {
    UserAuth.findAll(completion)
}
