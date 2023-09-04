//
//  UINavigationController+Extension.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation
import SwiftUI


extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 2
    }
}
