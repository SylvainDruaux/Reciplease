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
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
}
