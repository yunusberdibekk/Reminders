//
//  ReminderDateInputView.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 22.02.2024.
//

import UIKit

final class ReminderDateInputView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    private let dateLabel: BodyLabel = .init(
        textAlignment: .left,
        text: "Date",
        textColor: .label)

    let switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = .green
        switchView.preferredStyle = .sliding
        return switchView
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.isHidden = true
        datePicker.alpha = 0
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.date = .now
        datePicker.minimumDate = .now
        datePicker.maximumDate = .distantFuture
        return datePicker
    }()

    private let horizontalStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        prepareVerticalStackView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    public func configureSwitch(with date: Date?, _ isShowing: Bool) {
        switchView.isOn = isShowing
        datePicker.date = date ?? .distantFuture
        didTapSwitch()
    }
}

extension ReminderDateInputView {
    @objc
    private func didTapSwitch() {
        if switchView.isOn {
            UIView.animate(withDuration: 0.3) {
                self.datePicker.isHidden = false
                self.datePicker.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.datePicker.isHidden = true
                self.datePicker.alpha = 0
            }
        }
    }
}

extension ReminderDateInputView {
    private func prepareView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 5
        clipsToBounds = true

        switchView.addTarget(self, action: #selector(didTapSwitch), for: .valueChanged)
    }

    private func prepareVerticalStackView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(imageView)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(dateLabel)

        switchView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(switchView)

        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(horizontalStackView)

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(datePicker)

        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            verticalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: verticalStackView.bottomAnchor, multiplier: 1),
        ])
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1).isActive = true
    }
}
