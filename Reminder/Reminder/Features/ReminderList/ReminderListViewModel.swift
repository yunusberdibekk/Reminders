//
//  ReminderListViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import Foundation

protocol ReminderListViewModelInterface {
    var view: ReminderListViewControllerInterface? { get set }
    var reminderDefaultsManager: UserDefaultsManagerInterface { get }
    var reminders: [Reminder] { get }

    func viewDidLoad()
    func viewWillAppear()
    func didCalledObservers()
    func didTappedCreateButton()
    func didSelectRow(_ reminder: Reminder?)
}

final class ReminderListViewModel {
    weak var view: ReminderListViewControllerInterface?
    private(set) var reminderDefaultsManager: UserDefaultsManagerInterface
    private(set) var reminders: [Reminder] = []

    init(reminderDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager.shared) {
        self.reminderDefaultsManager = reminderDefaultsManager
    }

    private func fetchReminders() {
        reminderDefaultsManager.fetchObject(.reminders, expecting: [Reminder].self) { [weak self] result in
            switch result {
            case .success(let reminders):
                DispatchQueue.main.async {
                    self?.reminders = reminders
                    self?.view?.reloadTableView()
                }
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
        view?.prepareObservers()
        fetchReminders()
    }

    func viewWillAppear() {
        fetchReminders()
    }

    func didTappedCreateButton() {
        view?.present(target: ReminderCreateViewController())
    }

    func didCalledObservers() {
        fetchReminders()
    }

    func didSelectRow(_ reminder: Reminder?) {
        guard let reminder else { return }
        view?.present(target: ReminderDetailViewController(reminder: reminder))
    }
}
