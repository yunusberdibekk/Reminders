//
//  ReminderCreateViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 15.02.2024.
//

import Foundation

protocol ReminderCreateViewModelInterface {
    var view: ReminderCreateViewControllerInterface? { get set }
//    var userDefaultsManager: UserDefaultsManagerInterface { get }

    func viewDidLoad()
    func didTapCancelButton()
    func didTapDoneButton()
}

final class ReminderCreateViewModel: ReminderCreateViewModelInterface {
    weak var view: ReminderCreateViewControllerInterface?
    private let reminderDefaultManager: ReminderDefaultsManager = .init()
    //  private(set) var userDefaultsManager: UserDefaultsManagerInterface

//    init(userDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager.shared) {
//        self.userDefaultsManager = userDefaultsManager
//    }
}

extension ReminderCreateViewModel {
    func viewDidLoad() {
        view?.prepareViewController()
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
        reminderDefaultManager.update(with: reminder, actionType: .add) { error in
            if error == nil {
                print("işlem başarılı")
            } else {
                print("işlem başarısız")
            }
        }

        // SEND NOTİFİCATİON
    }
}
