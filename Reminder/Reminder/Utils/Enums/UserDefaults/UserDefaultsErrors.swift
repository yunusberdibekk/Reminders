//
//  UserDefaultsError.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 18.02.2024.
//

import Foundation

enum UserDefaultsErrors: String, Error {
    case unableToReminders = "Unable to reminders list"
    case alreadyInReminders = "This reminder already in reminders list."
    case invalidData = "Invalid data"
}
