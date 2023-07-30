//
//  UIView + Ext.swift
//  ToDoListDSApp
//
//  Created by Роман Цуприк on 29.07.23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
