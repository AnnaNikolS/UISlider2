//
//  ViewController.swift
//  UISlider2
//
//  Created by Анна on 20.02.2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setViewColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.delegate = self
            settingsVC.viewColor = view.backgroundColor
        } else { return }
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setViewColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
