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
    
    // MARK: - Public Properties
    var viewColor: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        colorSettingsView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redTextField, greenTextField, blueTextField)
        setValue(for: redLabel, greenLabel, blueLabel)
        
        colorSettingsView.backgroundColor = viewColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IB Actions
    @IBAction func pressedSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        setColor()
    }
    
    @IBAction func pressedDoneButton() {
        delegate.setViewColor(colorSettingsView.backgroundColor ?? .black)
        dismiss(animated: true)
    }
}

//MARK: - Private Methods
extension SettingsViewController {
    
    // Method for setting color in view
    private func setColor() {
        colorSettingsView.backgroundColor = UIColor(
            cgColor: .init(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1)
        )
    }
    
    // String conversion method
    private func string(slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    // Methods for transferring values to elements
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(slider: redSlider)
            case greenLabel:
                greenLabel.text = string(slider: greenSlider)
            default:
                blueLabel.text = string(slider: blueSlider)
            }
        }
    }
    
    private func setValue(for sliders: UISlider...) {
        let rgbColor = CIColor(color: viewColor)
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(rgbColor.red)
            case greenSlider:
                greenSlider.value = Float(rgbColor.green)
            default:
                blueSlider.value = Float(rgbColor.blue)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(slider: redSlider)
            case greenTextField:
                textField.text = string(slider: greenSlider)
            default:
                textField.text = string(slider: blueSlider)
            }
        }
    }
    
    // ShowAlert
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(title: "Wrong format!", message: "Please enter correct value")
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(title: "Wrong format!", message: "Please enter correct value", textField: textField)
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redLabel)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueLabel)
        }
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let separator = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.items = [separator, doneButton]
    }
}


