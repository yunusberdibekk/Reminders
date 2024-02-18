//
//  ReminderDefaultsManager.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 18.02.2024.
//

import Foundation

enum ReminderDefaultsError: String, Error {
    case alreadyInReminders = "This reminder already in reminders list."
    case unableToReminders = "Unable to reminders."
    case invalidData = "Invalid data"
    case decoderError = "Decoder error"
}

final class ReminderDefaultsManager {
    enum Keys {
        static let reminders = "reminders"
    }

    enum ActionType {
        case add
        case remove
    }

    func update(with reminder: Reminder, actionType: ActionType, completion: @escaping (ReminderDefaultsError?) -> Void) {
        fetch { result in
            switch result {
            case .success(var reminders):
                switch actionType {
                case .add:
                    reminders.append(reminder)
                case .remove:
                    reminders.removeAll(where: { $0.id == reminder.id })
                }
                completion(self.save(reminder: reminders))
            case .failure(let error):
                completion(error)
            }
        }
    }

    func fetch(completion: @escaping (Result<[Reminder], ReminderDefaultsError>) -> Void) {
        guard let data = UserDefaults.standard.object(forKey: Keys.reminders) as? Data else {
            completion(.success([]))
            return
        }

        do {
            let models = try JSONDecoder().decode([Reminder].self, from: data)
            completion(.success(models))
        } catch {
            completion(.failure(.decoderError))
        }
    }

    func save(reminder: [Reminder]) -> ReminderDefaultsError? {
        do {
            let encodedModels = try JSONEncoder().encode(reminder)

            UserDefaults.standard.setValue(encodedModels, forKey: Keys.reminders)
        } catch {
            return .unableToReminders
        }
        return nil
    }
}
