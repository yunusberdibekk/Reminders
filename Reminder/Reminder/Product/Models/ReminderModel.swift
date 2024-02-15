//
//  ReminderModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import Foundation

struct Reminder: Codable {
    let id: String
    var title: String
    var description: String
    var endingDate: Date
    var isChecked: Bool
}
