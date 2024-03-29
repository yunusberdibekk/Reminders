//
//  ReminderCreateViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 15.02.2024.
//

import Foundation

protocol ReminderCreateViewModelInterface {
    var view: ReminderCreateViewControllerInterface? { get set }
    var reminderDefaultsManager: UserDefaultsManagerInterface { get }

    func viewDidLoad()
    func didTapCancelButton()
    func didTapDoneButton()
}

final class ReminderCreateViewModel: ReminderCreateViewModelInterface {
    private(set) var reminderDefaultsManager: UserDefaultsManagerInterface
    weak var view: ReminderCreateViewControllerInterface?

    init(reminderDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager.shared) {
        self.reminderDefaultsManager = reminderDefaultsManager
    }

    private func postNotification() {
        NotificationCenter.default.post(name: .updateReminderList, object: nil)
    }
}

extension ReminderCreateViewModel {
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareNavigationBar()
        view?.prepareReminderTextInputView()
        view?.prepareReminderDateInputView()
    }

    func didTapCancelButton() {
        view?.dismiss()
    }

    func didTapDoneButton() {
        guard let title = view?.reminderTitle, let date = view?.date, let isOn = view?.isOn else { return }
        let reminder = Reminder(
            id: UUID().uuidString,
            title: title,
            description: view?.reminderDescription,
            endingDate: isOn ? date : nil,
            isChecked: false)

        reminderDefaultsManager.fetchObject(.reminders, expecting: [Reminder].self) { [weak self] result in
            switch result {
            case .success(var reminders):
                guard !reminders.contains(where: { $0.id == reminder.id }) else { return }
                reminders.append(reminder)
                let error = self?.reminderDefaultsManager.saveObject(.reminders, expecting: reminders)
                guard error == nil else {
                    print("Başarısız") // Show error
                    return
                }
                self?.postNotification()
                self?.view?.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
