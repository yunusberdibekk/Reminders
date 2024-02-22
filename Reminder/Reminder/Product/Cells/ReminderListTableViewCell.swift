//
//  ReminderListTableViewCell.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 14.02.2024.
//

import SnapKit
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
        checkedButton.translatesAutoresizingMaskIntoConstraints = false
        checkedButton.addTarget(self, action: #selector(didTapCheckedButton), for: .touchUpInside)

        checkedButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(8)
            make.leading.equalTo(snp.leading).offset(8)
        }
    }

    private func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(8)
            make.trailing.equalTo(snp.trailing).offset(-30)
            make.width.equalToSuperview().multipliedBy(0.805)
        }
    }

    private func prepareDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(32)
            make.trailing.equalTo(snp.trailing).offset(-30)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }

    private func prepareInfoButton() {
        addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)

        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-8)
        }
    }

    // TODO: UPDATE CHECKED BUTTON. AND GO TO USERDEFAULTS CONFİGURE THİS REMİNDER.
    @objc private func didTapCheckedButton() {
        reminder?.isChecked.toggle()
        delegate?.didTapCheckedButton(reminder)
    }

    @objc private func didTapInfoButton() {
        delegate?.didTapInfoButton(reminder)
    }
}
