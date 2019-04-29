//
//  JournalEntry.swift
//  Application
//
//  Created by Patel, Virenkumar on 4/22/19.
//

import Foundation
import SwiftKueryORM
import KituraContracts

struct JournalEntry: Model {
    var id: String?
    var emoji: String
    var date: Date
}

struct JournalEntryParams: QueryParams {
    var emoji: String?
}
