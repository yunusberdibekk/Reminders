//
//  ReminderListViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import Foundation

protocol ReminderListViewModelInterface {
    var view: ReminderListViewControllerInterface? { get set }
    var reminders: [Reminder] { get }

    func viewDidLoad()
    func viewWillAppear()
    func didTapCreateButton()
}

final class ReminderListViewModel {
    weak var view: ReminderListViewControllerInterface?
    private(set) var reminders: [Reminder] = [
        .init(
            id: UUID().uuidString,
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            description: "",
            endingDate: .now,
            isChecked: true),
        .init(
            id: UUID().uuidString,
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            description: "",
            endingDate: .now,
            isChecked: false),
        .init(
            id: UUID().uuidString,
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            description: "",
            endingDate: .now,
            isChecked: true),
    ]
}

extension ReminderListViewModel: ReminderListViewModelInterface {
    func viewDidLoad() {
        view?.prepareViewController()
        view?.prepareTableView()
    }

    func viewWillAppear() {}

    func didTapCreateButton() {
        view?.present(target: ReminderCreateViewController())
    }
}
