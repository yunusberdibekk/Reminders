//
//  ReminderListTableViewCell.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import UIKit

protocol ReminderListTableViewCellInterface: AnyObject {
    func didTapCheckedButton(_ reminder: Reminder?)
    func didTapInfoButton(_ reminder: Reminder?)
}

final class ReminderListTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "ReminderListTableViewCell"
    weak var delegate: ReminderListTableViewCellInterface?

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

    private let infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
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

        prepareCell()
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

    private func changeCheckedButtonStatus() {
        checkedButton.configuration?.image = UIImage(systemName: "checkmark.circle")?.withTintColor(reminder?.isChecked == true ? .systemGreen : .lightGray, renderingMode: .alwaysOriginal)
    }
}

extension ReminderListTableViewCell {
    private func prepareCell() {
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        backgroundColor = .systemBackground

        prepareCheckedButton()
        prepareTitleLabel()
        prepareDescriptionLabel()
        prepareInfoButton()
    }

    private func prepareCheckedButton() {
        addSubview(checkedButton)
        checkedButton.addTarget(self, action: #selector(didTapCheckedButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            checkedButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            checkedButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
        ])
    }

    private func prepareTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 3.5),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.805),
        ])
    }

    private func prepareDescriptionLabel() {
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 4.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionLabel.trailingAnchor, multiplier: 3.5),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }

    private func prepareInfoButton() {
        addSubview(infoButton)
        infoButton.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: infoButton.trailingAnchor, multiplier: 1),
        ])
    }

    // TODO: UPDATE CHECKED BUTTON. AND GO TO USERDEFAULTS CONFİGURE THİS REMİNDER.
    @objc private func didTapCheckedButton() {
        reminder?.isChecked.toggle()
    }

    @objc private func didTapInfoButton() {
        delegate?.didTapInfoButton(reminder)
    }
}
