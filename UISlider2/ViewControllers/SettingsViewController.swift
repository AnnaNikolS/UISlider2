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
    
    var backgroundColorView: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        colorSettingsView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setValueForLabels(redLabel, greenLabel, blueLabel)
        setValueForSliders(redSlider, greenSlider, blueSlider)
        
        colorSettingsView.backgroundColor = backgroundColorView
    }
    
    @IBAction func pressedSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValueForLabels(redLabel)
        case greenSlider:
            setValueForLabels(greenLabel)
        default:
            setValueForLabels(blueLabel)
        }
        
        colorSettingsView.backgroundColor = UIColor(
            cgColor: .init(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1)
        )
    }
    
    //упростить
    private func setValueForLabels(_ rgbLabels: UILabel...) {
        rgbLabels.forEach { label in
            switch label {
            case redLabel:
                redSlider.value = Float(CGFloat(round(redSlider.value  *  100) / 100))
                redLabel.text = redSlider.value.formatted()
                redTextField.text = redSlider.value.formatted()
            case greenLabel:
                greenSlider.value = Float(CGFloat(round(greenSlider.value * 100) / 100))
                greenLabel.text = greenSlider.value.formatted()
                greenTextField.text = greenSlider.value.formatted()
            default:
                blueSlider.value = Float(CGFloat(round(blueSlider.value * 100) / 100))
                blueLabel.text = blueSlider.value.formatted()
                blueTextField.text = blueSlider.value.formatted()
            }
        }
    }
    
    private func setValueForSliders(_ sliders: UISlider...) {
        let rgbColor = CIColor(color: backgroundColorView)
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(rgbColor.red)
                setValueForLabels(redLabel)
            case greenSlider:
                greenSlider.value = Float(rgbColor.green)
                setValueForLabels(greenLabel)
            default:
                blueSlider.value = Float(rgbColor.blue)
                setValueForLabels(blueLabel)
            }
        }
    }
    
    @IBAction func pressedDoneButton() {
        delegate.setViewColor(colorSettingsView.backgroundColor)
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
}
