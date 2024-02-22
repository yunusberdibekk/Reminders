//
//  ReminderTextInputView.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 22.02.2024.
//

import SnapKit
import UIKit

final class ReminderTextInputView: UIView {
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.placeholder = "Title"
        textField.textColor = .lightGray
        textField.textAlignment = .left
        return textField
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .callout)
        textView.textColor = .lightGray
        textView.textAlignment = .left

        return textView
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ReminderTextInputView {
    private func prepareView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        clipsToBounds = true

        prepareStackView()
    }

    private func prepareStackView() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleTextField)

        dividerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(dividerView)

        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(descriptionTextView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(8)
            make.leading.equalTo(snp.leading).offset(8)
            make.trailing.equalTo(snp.trailing).offset(-8)
            make.bottom.equalTo(snp.bottom).offset(-8)
        }

        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
