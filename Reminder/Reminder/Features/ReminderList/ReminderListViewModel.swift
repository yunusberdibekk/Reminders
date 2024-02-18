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
//    private let reminderDefaultManager = ReminderDefaultsManager()

    init(userDefaultsManager: UserDefaultsManagerInterface = ReminderDefaults()) {
        self.userDefaultsManager = userDefaultsManager
    }

    private func fetchReminders() {
        userDefaultsManager.fetchObject(.reminders, expecting: [Reminder].self) { result in
            switch result {
            case .success(let reminders):
                dump(reminders)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

//    private func fetchReminders() {
//        reminderDefaultManager.fetch { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let models):
//                dump(models)
//                DispatchQueue.main.async {
//                    self.reminders = models
//                    self.view?.reloadTableView()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}

extension ReminderListViewModel: ReminderListViewModelInterface {
    func viewDidLoad() {
        view?.prepareViewController()
        view?.prepareTableView()
        fetchReminders()
    }

    func viewWillAppear() {
        fetchReminders()
    }

    func didTapCreateButton() {
        view?.present(target: ReminderCreateViewController())
    }
}
