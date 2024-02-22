//
//  Dismissable.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 22.02.2024.
//

import UIKit

protocol Dismissable {
    func dismiss()
}

extension Dismissable where Self: UIViewController {
    func dismiss() {
        self.dismiss(animated: true)
    }
}
