//
//  FirstSectionView.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 17.02.2024.
//

import UIKit

final class FirstSectionView: UIView {
    lazy var titleTextField: CustomTextField = .init(
        placeholder: "Title")

    lazy var descriptionTextField: CustomTextField = .init(placeholder: "Description")

    lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        prepareStackView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FirstSectionView {
    private func prepareView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 5
        clipsToBounds = true
    }

    private func prepareStackView() {
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(descriptionTextField)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
