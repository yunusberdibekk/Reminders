//
//  ReminderCreateViewController.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 13.02.2024.
//

import UIKit

protocol ReminderCreateViewControllerInterface: AnyObject {
    var reminderTitle: String? { get }
    var reminderDescription: String? { get }
    var isOn: Bool { get }
    var date: Date { get }

    func prepareViewController()
    func dismiss()
}

final class ReminderCreateViewController: UIViewController {
    private lazy var viewModel: ReminderCreateViewModelInterface = ReminderCreateViewModel()

    private let firstSectionView: FirstSectionView = .init()
    private let secondSectionView: SecondSectionView = .init()

    var reminderTitle: String? {
        firstSectionView.titleTextField.text
    }

    var reminderDescription: String? {
        firstSectionView.descriptionTextField.text
    }

    var isOn: Bool {
        secondSectionView.switchView.isOn
    }

    var date: Date {
        secondSectionView.datePicker.date
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @objc private func didTapCancelButton() {
        viewModel.didTapCancelButton()
    }

    @objc private func didTapDoneButton() {
        viewModel.didTapDoneButton()
    }
}

extension ReminderCreateViewController: ReminderCreateViewControllerInterface {
    func prepareViewController() {
        view.backgroundColor = .secondarySystemBackground
        prepareNavigationBar()
        prepareFirstSectionView()
        prepareSecondSectionView()
    }

    func dismiss() {
        dismiss(animated: true)
    }
}

extension ReminderCreateViewController {
    private func prepareNavigationBar() {
        title = "Create"
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

    private func prepareFirstSectionView() {
        firstSectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstSectionView)

        NSLayoutConstraint.activate([
            firstSectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            firstSectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: firstSectionView.trailingAnchor, multiplier: 2)
        ])
    }

    private func prepareSecondSectionView() {
        secondSectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondSectionView)

        NSLayoutConstraint.activate([
            secondSectionView.topAnchor.constraint(equalToSystemSpacingBelow: firstSectionView.bottomAnchor, multiplier: 2),
            secondSectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: secondSectionView.trailingAnchor, multiplier: 2)
        ])
    }
}
