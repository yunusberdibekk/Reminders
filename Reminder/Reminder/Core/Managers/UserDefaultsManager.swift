//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 15.02.2024.
//

import Foundation

enum UserDefaultsKeys: String {
    case reminders
}

protocol UserDefaultsManagerInterface {
    func fetchObject<T: Codable>(_ key: UserDefaultsKeys,
                                 expecting type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
    func saveObject<T: Encodable>(_ key: UserDefaultsKeys,
                                  expecting type: T) -> Error?
    func removeObject(_ key: UserDefaultsKeys)
}

final class UserDefaultsManager: UserDefaultsManagerInterface {
    static let shared: UserDefaultsManager = .init()

    private init() {}

    func fetchObject<T: Codable>(_ key: UserDefaultsKeys,
                                 expecting type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
    {
        guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            return
        }

        do {
            let results = try JSONDecoder().decode(type.self, from: data)

            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }

    func saveObject<T: Encodable>(_ key: UserDefaultsKeys,
                                  expecting type: T) -> Error?
    {
        do {
            let encodedModels = try JSONEncoder().encode(type.self)

            UserDefaults.standard.setValue(encodedModels, forKey: key.rawValue)
        } catch {
            return error
        }

        return nil
    }

    func removeObject(_ key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
