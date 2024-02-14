//
//  ReminderListViewModel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import Foundation

protocol ReminderListViewModelInterface {
    var view: ReminderListViewControllerInterface? { get set }

    func viewDidLoad()
    func viewWillAppear()
}

final class ReminderListViewModel {
    weak var view: ReminderListViewControllerInterface?
}

extension ReminderListViewModel: ReminderListViewModelInterface {
    func viewDidLoad() {
        view?.prepareViewController()
        view?.prepareTableView()
    }

    func viewWillAppear() {}
}
