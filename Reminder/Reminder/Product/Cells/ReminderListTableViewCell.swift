//
//  ReminderListTableViewCell.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import UIKit

final class ReminderListTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "ReminderListTableViewCell"

    private var reminder: Reminder? {
        didSet {
            changeCheckedButtonStatus()
        }
    }

    private let checkedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .secondarySystemBackground
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.9
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.textColor = .lightGray
        label.text = "Lorem ipsum dolor sit amet amet Lorem ipsum dolor sit amet amet"
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        label.textColor = .label
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        accessoryType = .disclosureIndicator
        prepareCheckedButton()
        prepareTitleLabel()
        prepareDescriptionLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    public func configure(with reminder: Reminder) {
        self.reminder = reminder
        titleLabel.text = reminder.title
        descriptionLabel.text = reminder.description
    }

    // add target to checkedButton. update register model with userdefaults
    private func changeCheckedButtonStatus() {
        checkedButton.configuration?.image = UIImage(systemName: "checkmark.circle")?.withTintColor(reminder?.isChecked == true ? .systemGreen : .lightGray, renderingMode: .alwaysOriginal)
    }
}

extension ReminderListTableViewCell {
    private func prepareCheckedButton() {
        addSubview(checkedButton)

        NSLayoutConstraint.activate([
            checkedButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            checkedButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
        ])
    }

    private func prepareTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
        ])
    }

    private func prepareDescriptionLabel() {
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 4.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionLabel.trailingAnchor, multiplier: 1),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
        ])
    }
}
