//
//  Presentable.swift
//  Reminder
//
//  Created by Yunus Emre Berdibek on 15.02.2024.
//

import UIKit

protocol Presentable {
    func present(target: UIViewController)
}

extension Presentable where Self: UIViewController {
    func present(target: UIViewController) {
        self.present(
            UINavigationController(rootViewController: target),
            animated: true)
    }
}
