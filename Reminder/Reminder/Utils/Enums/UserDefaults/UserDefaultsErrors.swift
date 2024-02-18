//
//  UserDefaultsError.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 18.02.2024.
//

import Foundation

enum UserDefaultsErrors: String, Error {
    case unableToReminders
    case alreadyInReminders
    case invalidData
}
