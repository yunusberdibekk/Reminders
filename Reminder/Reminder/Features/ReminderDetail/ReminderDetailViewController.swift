//
//  ReminderDetailViewController.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 13.02.2024.
//

import UIKit

protocol ReminderDetailViewControllerInterface: AnyObject, Dismissable {
    var reminder: Reminder { get }
    var reminderTitle: String? { get }
    var reminderDescription: String? { get }
    var isOn: Bool { get }
    var date: Date { get }

    func prepareView()
    func prepareNavigationBar()
    func prepareReminderTextInputView()
    func prepareReminderDateInputView()
}

final class ReminderDetailViewController: UIViewController, ReminderCreateViewControllerInterface {
    // MARK: - UI Components.

    private let reminderTextInputView: ReminderTextInputView = .init()
    private let reminderDateInputView: ReminderDateInputView = .init()

    // MARK: - Variables

    let reminder: Reminder
    private let viewModel: ReminderDetailViewModel = .init()

    private var isShowingDate: Bool {
        reminder.endingDate != nil
    }

    var reminderTitle: String? {
        reminderTextInputView.titleTextField.text
    }

    var reminderDescription: String? {
        reminderTextInputView.descriptionTextView.text
    }

    var isOn: Bool {
        reminderDateInputView.switchView.isOn
    }

    var date: Date {
        reminderDateInputView.datePicker.date
    }

    // MARK: - Lifecycle

    init(reminder: Reminder) {
        self.reminder = reminder
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - ReminderCreateViewController + Actions.

extension ReminderDetailViewController {
    @objc private func didTapCancelButton() {
        viewModel.didTapCancelButton()
    }

    @objc private func didTapDoneButton() {
        viewModel.didTapDoneButton(with: reminder)
    }
}

// MARK: - ReminderDetailViewController + ReminderDetailViewControllerInterface Extension.

extension ReminderDetailViewController: ReminderDetailViewControllerInterface {
    func prepareView() {
        view.backgroundColor = .secondarySystemBackground
        title = "Detail"
    }

    func prepareNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDoneButton))
    }

    func prepareReminderTextInputView() {
        reminderTextInputView.translatesAutoresizingMaskIntoConstraints = false
        reminderTextInputView.titleTextField.text = reminder.title
        reminderTextInputView.descriptionTextView.text = reminder.description

        view.addSubview(reminderTextInputView)

        NSLayoutConstraint.activate([
            reminderTextInputView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            reminderTextInputView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: reminderTextInputView.trailingAnchor, multiplier: 2),
            reminderTextInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }

    func prepareReminderDateInputView() {
        reminderDateInputView.translatesAutoresizingMaskIntoConstraints = false
        reminderDateInputView.configureSwitch(with: reminder.endingDate, isShowingDate)
        view.addSubview(reminderDateInputView)

        NSLayoutConstraint.activate([
            reminderDateInputView.topAnchor.constraint(equalToSystemSpacingBelow: reminderTextInputView.bottomAnchor, multiplier: 2),
            reminderDateInputView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: reminderDateInputView.trailingAnchor, multiplier: 2),
        ])
    }
}
