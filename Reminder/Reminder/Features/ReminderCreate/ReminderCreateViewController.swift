//
//  ReminderCreateViewController.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 13.02.2024.
//

import UIKit

protocol ReminderCreateViewControllerInterface: AnyObject {
    var date: Date { get }

    func prepareViewController()
}

final class ReminderCreateViewController: UIViewController {
    private lazy var firstSectionView: FirstSectionView = .init()
    private lazy var secondSectionView: SecondSectionView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        prepareNavigationBar()
        prepareFirstSectionView()
        prepareSecondSectionView()
    }
}

extension ReminderCreateViewController {
    private func prepareNavigationBar() {
        title = "Create"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: nil,
            action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: nil,
            action: nil)
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
