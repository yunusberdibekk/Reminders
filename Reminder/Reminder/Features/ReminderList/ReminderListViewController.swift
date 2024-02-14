//
//  ReminderListViewController.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 13.02.2024.
//

import UIKit

protocol ReminderListViewControllerInterface: AnyObject {
    func prepareViewController()
    func prepareTableView()
}

final class ReminderListViewController: UIViewController {
    private lazy var viewModel: ReminderListViewModelInterface = ReminderListViewModel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.register(
            ReminderListTableViewCell.self,
            forCellReuseIdentifier: ReminderListTableViewCell.reuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension ReminderListViewController: ReminderListViewControllerInterface {
    func prepareViewController() {
        view.backgroundColor = .systemBackground
        title = "Reminders"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }

    func prepareTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalToSystemSpacingBelow: view.topAnchor,
                multiplier: 1),
            tableView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor,
                multiplier: 0),
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: tableView.trailingAnchor,
                multiplier: 0),
            tableView.bottomAnchor.constraint(
                equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor,
                multiplier: 0)
        ])
    }
}

extension ReminderListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReminderListTableViewCell.reuseIdentifier,
            for: indexPath) as! ReminderListTableViewCell

        cell.contentView.isUserInteractionEnabled = false
        cell.configure(with: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
