//
//  AppearanceViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import UIKit

protocol AppearanceViewControllerDelegate: AnyObject {
    func didSelectStyle(_ appearanceViewController: AppearanceViewController)
}

final class AppearanceViewController: UIViewController {

    @IBOutlet private var appearanceTableView: UITableView!
    
    private var viewModel = AppearanceViewModel().cellsViewModel
    private let userInterfaceStyle = UserPreferences.userInterfaceStyle
    
    weak var delegate: AppearanceViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearanceTableView.dataSource = self
        appearanceTableView.delegate = self
    }
    
    private func updateInterfaceStyle(_ newStyle: String) {
        UserPreferences.userInterfaceStyle = newStyle
    }
    
    private func changeUserInterfaceStyle(to style: String) {
        updateInterfaceStyle(style)
        guard let window = view.window else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            switch style {
            case "light":
                window.overrideUserInterfaceStyle = .light
            case "dark":
                window.overrideUserInterfaceStyle = .dark
            default:
                window.overrideUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle
            }
        })
    }
}

extension AppearanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppearanceCell", for: indexPath) as? AppearanceTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        if model.style == userInterfaceStyle {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // Uncheck all visible cells
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else { return }
        for visibleIndexPath in visibleIndexPaths {
            let visibleCell = tableView.cellForRow(at: visibleIndexPath)
            visibleCell?.accessoryType = .none
        }
        
        guard cell.accessoryType == .none else { return }
        cell.accessoryType = .checkmark
        let model = viewModel[indexPath.row]
        changeUserInterfaceStyle(to: model.style)
        delegate?.didSelectStyle(self)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}

extension AppearanceViewController: UITableViewDelegate { }
