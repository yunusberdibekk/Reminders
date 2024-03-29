//
//  ReminderListViewController.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 13.02.2024.
//

import SnapKit
import UIKit

protocol ReminderListViewControllerInterface: AnyObject, Presentable {
    func prepareViewController()
    func prepareTableView()
    func reloadTableView()
    func prepareObservers()
}

final class ReminderListViewController: UIViewController {
    private let viewModel: ReminderListViewModel = .init()

    private let tableView: UITableView = {
        let tableView = UITableView()
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

// MARK: - ReminderListViewController + Actions

extension ReminderListViewController {
    @objc private func didTappedCreateButton() {
        viewModel.didTappedCreateButton()
    }

    @objc private func updateReminderList() {
        viewModel.didCalledObservers()
    }
}

// MARK: - ReminderListViewController + ReminderListViewControllerInterface Extension.

extension ReminderListViewController: ReminderListViewControllerInterface {
    func prepareViewController() {
        view.backgroundColor = .systemBackground
        title = "Reminders"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTappedCreateButton))
    }

    func prepareTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func prepareObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateReminderList),
            name: .updateReminderList,
            object: nil)
    }
}

// MARK: - ReminderListViewController + ReminderListTableViewCellInterface Extension.

extension ReminderListViewController: ReminderListTableViewCellInterface {
    func didTapCheckedButton(_ reminder: Reminder?) {
        guard let reminder else { return }
        viewModel.didTapCheckedButton(reminder)
    }

    func didTapInfoButton(_ reminder: Reminder?) {
        viewModel.didSelectRow(reminder)
    }
}

// MARK: - ReminderListViewController + UITableViewDataSource ,UITableViewDelegate Extension.

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

        cell.delegate = self
        cell.configure(with: reminder)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let reminder = viewModel.reminders[indexPath.row]
        let descStringCount = reminder.description?.count ?? 0

        if descStringCount >= 100 {
            return 100
        } else if descStringCount >= 75 {
            return 90
        } else if descStringCount >= 50 {
            return 80
        } else {
            return 60
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            self?.viewModel.didTappedDeleteButton(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
