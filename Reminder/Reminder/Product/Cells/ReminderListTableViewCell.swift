//
//  ReminderListTableViewCell.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import UIKit

final class ReminderListTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "ReminderListTableViewCell"

    private let checkedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .systemBackground
        button.configuration?.image = UIImage(systemName: "checkmark.circle")?
            .withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareCheckedButton()
        prepareTitleLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func prepareCheckedButton() {
        addSubview(checkedButton)
        checkedButton.addTarget(self, action: #selector(didTapCheckedButton), for: .allEvents)

        NSLayoutConstraint.activate([
            checkedButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            checkedButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            checkedButton.widthAnchor.constraint(equalToConstant: frame.width * 0.1),
            checkedButton.heightAnchor.constraint(equalToConstant: frame.width * 0.1),
        ])
    }

    private func prepareTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            titleLabel.widthAnchor.constraint(equalToConstant: frame.width * 1),
        ])
    }

    @objc
    private func didTapCheckedButton() {
        UIView.animate(springDuration: 0.5) {
            checkedButton.configuration?.image = UIImage(systemName: "checkmark.circle")?
                .withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        }
    }
}

extension ReminderListTableViewCell {
    public func configure(with title: String) {
        titleLabel.text = title
    }
}
