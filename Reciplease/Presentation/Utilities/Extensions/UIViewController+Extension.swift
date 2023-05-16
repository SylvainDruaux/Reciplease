//
//  UIViewController+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 25/03/2023.
//

import UIKit

extension UIViewController {
    func showAlertWithAction(title: String, message: String, okAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            return
        }
        okAction.setValue(UIColor(named: "TextColor"), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(named: "TextColor"), forKey: "titleTextColor")
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func presentAlert(title: String? = nil, message: String, actionTitle: String = "OK") {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel)
        alertAction.setValue(UIColor(named: "TextColor"), forKey: "titleTextColor")
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true)
    }
}
