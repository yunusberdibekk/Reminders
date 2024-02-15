//
//  ReminderListViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import Foundation

protocol ReminderListViewModelInterface {
    var view: ReminderListViewControllerInterface? { get set }
    var userDefaultsManager: UserDefaultsManagerInterface { get }
    var reminders: [Reminder] { get }

    func viewDidLoad()
    func viewWillAppear()
    func didTapCreateButton()
}

final class ReminderListViewModel {
    weak var view: ReminderListViewControllerInterface?
    private(set) var userDefaultsManager: UserDefaultsManagerInterface
    private(set) var reminders: [Reminder] = []

    init(userDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager.shared) {
        self.userDefaultsManager = userDefaultsManager
    }

    private func fetchReminders() {
        userDefaultsManager.fetchObject(.reminders, expecting: [Reminder].self) { result in
            switch result {
            case .success(let models):
                self.reminders = models
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ReminderListViewModel: ReminderListViewModelInterface {
    func viewDidLoad() {
        view?.prepareViewController()
        view?.prepareTableView()
        fetchReminders()
    }

    func viewWillAppear() {
        fetchReminders()
        view?.reloadTableView()
    }

    func didTapCreateButton() {
        view?.present(target: ReminderCreateViewController())
    }
}
