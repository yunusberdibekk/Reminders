//
//  ReminderDetailViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 22.02.2024.
//

import Foundation

protocol ReminderDetailViewModelInterface {
    var view: ReminderCreateViewControllerInterface? { get set }
    var reminderDefaultsManager: UserDefaultsManagerInterface { get }

    func viewDidLoad()
    func didTapCancelButton()
    func didTapDoneButton(with reminder: Reminder)
}

final class ReminderDetailViewModel: ReminderDetailViewModelInterface {
    private(set) var reminderDefaultsManager: UserDefaultsManagerInterface
    weak var view: ReminderCreateViewControllerInterface?

    init(reminderDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager.shared) {
        self.reminderDefaultsManager = reminderDefaultsManager
    }

    private func postNotification() {
        NotificationCenter.default.post(name: .updateReminderList, object: nil)
    }
}

extension ReminderDetailViewModel {
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareNavigationBar()
        view?.prepareReminderTextInputView()
        view?.prepareReminderDateInputView()
    }

    func didTapCancelButton() {
        view?.dismiss()
    }

    func didTapDoneButton(with reminder: Reminder) {
        guard let title = view?.reminderTitle, let date = view?.date, let isOn = view?.isOn else { return }
        let reminder = Reminder(
            id: reminder.id,
            title: title,
            description: view?.reminderDescription,
            endingDate: isOn ? date : nil,
            isChecked: reminder.isChecked)

        reminderDefaultsManager.fetchObject(.reminders, expecting: [Reminder].self) { result in
            switch result {
            case .success(var reminders):
                guard let index = reminders.firstIndex(where: { $0.id == reminder.id }) else { return }
                reminders[index] = reminder
                let error = self.reminderDefaultsManager.saveObject(.reminders, expecting: reminders)
                guard error == nil else {
                    print("Başarısız") // Show error
                    return
                }
                self.postNotification()
                self.view?.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
