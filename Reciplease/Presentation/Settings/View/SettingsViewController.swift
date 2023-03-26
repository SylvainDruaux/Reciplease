//
//  SettingsViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var settingsTableView: UITableView!
    
    private var viewModel = SettingViewModel().cellsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToAbout":
            if let aboutVC = segue.destination as? AboutViewController {
                aboutVC.title = NSLocalizedString("about_title", comment: "Title for the About screen")
            }
        case "goToAppearance":
            if let appearanceVC = segue.destination as? AppearanceViewController {
                appearanceVC.delegate = self
                appearanceVC.title = NSLocalizedString("appearance_title", comment: "Title for the Appearance screen")
            }
        default:
            break
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "goToAbout", sender: self)
        case 1:
            performSegue(withIdentifier: "goToAppearance", sender: self)
        default:
            break
        }
    }
}

extension SettingsViewController: UITableViewDelegate { }

// MARK: - AppearanceViewController Delegate to update the chosen appearance
extension SettingsViewController: AppearanceViewControllerDelegate {
    func didSelectStyle(_ appearanceViewController: AppearanceViewController) {
        viewModel = SettingViewModel().cellsViewModel
        settingsTableView.reloadData()
    }
}
