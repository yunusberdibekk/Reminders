//
//  SecondSectionView.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 17.02.2024.
//

import UIKit

final class SecondSectionView: UIView {
    private let symbolImage: SFSymbolView = .init(
        imageName: "calendar",
        backgroundColor: .systemRed)

    private let dateLabel: BodyLabel = .init(
        textAlignment: .left,
        text: "Date",
        textColor: .label)

    private let switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.isOn = false
        switchView.onTintColor = .green
        switchView.preferredStyle = .sliding
        return switchView
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isHidden = true
        datePicker.alpha = 0
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = .current
        datePicker.date = .now
        datePicker.minimumDate = .now
        datePicker.maximumDate = .distantFuture
        return datePicker
    }()

    private let horizontalStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
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

extension SecondSectionView {
    private func prepareView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 5
        clipsToBounds = true

        switchView.addTarget(self, action: #selector(didTapSwitch), for: .valueChanged)
    }

    private func prepareVerticalStackView() {
        horizontalStackView.addArrangedSubview(symbolImage)
        horizontalStackView.addArrangedSubview(dateLabel)
        horizontalStackView.addArrangedSubview(switchView)

        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(datePicker)
        addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            verticalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: verticalStackView.bottomAnchor, multiplier: 1)
        ])

        symbolImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
}
