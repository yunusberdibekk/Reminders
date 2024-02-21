//
//  SFSymbolView.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 17.02.2024.
//

import UIKit

final class SFSymbolView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(imageName: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.image = UIImage(systemName: imageName)?.withTintColor(
            .white,
            renderingMode: .alwaysOriginal)
        self.backgroundColor = backgroundColor
    }
}

extension SFSymbolView {
    private func prepareView() {
        contentMode = .center
        clipsToBounds = true
        layer.cornerRadius = 5
    }
}
