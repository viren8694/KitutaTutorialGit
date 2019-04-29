//
//  EntryRoutes.swift
//  Application
//
//  Created by Patel, Virenkumar on 4/22/19.
//

import Foundation
import LoggerAPI
import Kitura



var entries: [JournalEntry] = []
func initializeEntryRoutes(app: App) {
    app.router.get("/entries", handler: getEntries)
    app.router.post("/entries", handler: addEntry)
    app.router.delete("/entries", handler: deleteEntry)
    app.router.put("/entries", handler: modifyEntry)
    Log.info("Journal entry routes created")
}

//func addEntry(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
//    guard let contentType = request.headers["Content-Type"], contentType.hasPrefix("application/json") else {
//        response.status(.unsupportedMediaType)
//        response.send(["error": "Request Content-Type must be application/json"])
//        return next()
//    }
//    var entry: JournalEntry
//    do{
//        try entry = request.read(as: JournalEntry.self)
//    } catch {
//        response.status(.unprocessableEntity)
//        if let decodingError = error as? DecodingError {
//            response.send("Could not decode recevied data:" + "\(decodingError.humanReadableDescription)")
//        } else {
//            response.send("Could not Decode recevied Data.")
//        }
//        return next()
//    }
//    response.status(.created)
//    response.send(json: entry)
//    next()
//    //response.send("Hello, This is response from my first request.")
//}

func addEntry(entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    var storedEntry = entry
    storedEntry.id = entries.count.value
    entries.append(storedEntry)
    completion(entry, nil)
}

func getAllEntries(completion: @escaping ([JournalEntry]?, RequestError?) -> Void) -> Void {
    completion(entries, nil)
}

func getEntries(params: JournalEntryParams? , completion: @escaping ([JournalEntry]?, RequestError?) -> Void) -> Void {
    guard let params = params else {
        return completion(entries, nil)
    }
    let filteredEntries = entries.filter{$0.emoji == params.emoji}
    completion(filteredEntries, nil)
}

func modifyEntry(id: String,entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
    guard let index = entries.index(where: {$0.id == id}) else {
        return completion(nil, .notFound)
    }
    var storedEntry = entry
    storedEntry.id = id
    entries[index] = storedEntry
    completion(storedEntry, nil)
}

func deleteEntry(id: String, completion: @escaping (RequestError?) -> Void) {
    guard let index = entries.index(where: {$0.id == id}) else {
        return completion(.notFound)
    }
    entries.remove(at: index)
    completion(nil)
}

//func addEntry(entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
//    var savedEntry = entry
//    savedEntry.id = UUID().uuidString
//    savedEntry.save(completion)
//}

