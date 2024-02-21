//
//  ViewController.swift
//  UISlider2
//
//  Created by Анна on 20.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.delegate = self
            settingsVC.backgroundColorView = view.backgroundColor
        } else { return }
        
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func setViewColor(_ color: UIColor!)
}

extension MainViewController: SettingsViewControllerDelegate {
    func setViewColor(_ color: UIColor!) {
        view.backgroundColor = color
    }
}
