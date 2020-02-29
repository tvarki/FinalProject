//
//  UIViewControllerExtension.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.setValue(text.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Arial", size: 14),
                                                                 csscolor: UIColor.systemGray.hexString(.RRGGBB),
                                                                 lineheight: 5, csstextalign: "left"),
                       forKey: "attributedMessage")

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        subview.backgroundColor = UIColor.systemGray6
        present(alert, animated: true)
    }
}
