//
//  ReminderListViewController.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 13.02.2024.
//

import UIKit

protocol ReminderListViewControllerInterface: AnyObject, Presentable {
    func prepareViewController()
    func prepareTableView()
    func reloadTableView()
}

final class ReminderListViewController: UIViewController {
    private let viewModel: ReminderListViewModel = .init()

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateButton))
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

    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @objc private func didTapCreateButton() {
        viewModel.didTapCreateButton()
    }
}

extension ReminderListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.reminders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReminderListTableViewCell.reuseIdentifier,
            for: indexPath) as! ReminderListTableViewCell
        let reminder = viewModel.reminders[indexPath.row]
        cell.contentView.isUserInteractionEnabled = false
        cell.configure(for: reminder)
        return cell
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
