//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 15.02.2024.
//

import Foundation

protocol UserDefaultsManagerInterface {
    func fetchObject<T: Codable>(
        _ key: UserDefaultsKeys,
        expecting type: T.Type,
        completion: @escaping (Result<T, UserDefaultsErrors>) -> Void)

    func saveObject<T: Codable>(
        _ key: UserDefaultsKeys,
        expecting type: T) -> UserDefaultsErrors?

    func removeObject(_ key: UserDefaultsKeys)
}

extension UserDefaultsManagerInterface {
    func fetchObject<T: Codable>(
        _ key: UserDefaultsKeys,
        expecting type: T.Type,
        completion: @escaping (
            Result<T, UserDefaultsErrors>) -> Void)
    {
        guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            completion(.success([] as! T))
            return
        }

        do {
            let decoder = JSONDecoder()
            let objects = try decoder.decode(type.self, from: data)

            completion(.success(objects))
        } catch {
            completion(.failure(.unableToReminders))
        }
    }

    func saveObject<T: Codable>(
        _ key: UserDefaultsKeys,
        expecting value: T) -> UserDefaultsErrors?
    {
        do {
            let encoder = JSONEncoder()
            let encodedModels = try encoder.encode(value)

            UserDefaults.standard.setValue(encodedModels, forKey: key.rawValue)
        } catch {
            return .unableToReminders
        }

        return nil
    }

    func removeObject(_ key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

final class UserDefaultsManager: UserDefaultsManagerInterface {
    static let shared: UserDefaultsManager = .init()

    private init() {}
}
