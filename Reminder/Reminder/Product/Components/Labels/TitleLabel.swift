//
//  TitleLabel.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 19.02.2024.
//

import UIKit

final class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(textAlignment: NSTextAlignment, text: String? = nil, textColor: UIColor) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.text = text
        self.textColor = textColor
    }
}

extension TitleLabel {
    private func prepareLabel() {
        font = UIFont.preferredFont(forTextStyle: .title1)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 12
        numberOfLines = 0
    }
}
