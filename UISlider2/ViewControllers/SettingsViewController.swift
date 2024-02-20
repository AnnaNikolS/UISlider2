//
//  SettingsViewController.swift
//  UISlider2
//
//  Created by Анна on 20.02.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var colorSettingsView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var redValue: CGFloat = 0
    var greenValue: CGFloat = 0
    var blueValue: CGFloat = 0
    
    var backgroundColorView: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        colorSettingsView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorSettingsView.backgroundColor = backgroundColorView
     
    }
    
    
    
    @IBAction func pressedSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            redValue = CGFloat(round(redSlider.value  *  100) / 100)
            redLabel.text = redValue.formatted()
        case greenSlider:
            greenValue = CGFloat(round(greenSlider.value * 100) / 100)
            greenLabel.text = greenValue.formatted()
        default:
            blueValue = CGFloat(round(blueSlider.value * 100) / 100)
            blueLabel.text = blueValue.formatted()
            
        }
        
            colorSettingsView.backgroundColor = UIColor(
                cgColor: .init(
                    red: redValue,
                    green: greenValue,
                    blue: blueValue,
                    alpha: 1)
            )
        
        
    }
    
}
