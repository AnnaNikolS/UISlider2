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
        
       // dataTransferFromTF(redTextField, greenTextField, blueTextField)
        
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
               // redSlider.value = Float(redTextField.text!)!
            case greenLabel:
                greenSlider.value = Float(CGFloat(round(greenSlider.value * 100) / 100))
                greenLabel.text = greenSlider.value.formatted()
                greenTextField.text = greenSlider.value.formatted()
               // greenTextField.text = greenLabel.text
            default:
                blueSlider.value = Float(CGFloat(round(blueSlider.value * 100) / 100))
                blueLabel.text = blueSlider.value.formatted()
                blueTextField.text = blueSlider.value.formatted()
               // blueTextField.text = blueLabel.text
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
    
    private func textFieldSetting() {
        
    }
    
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
//
//    private func dataTransferFromTF(_ textFields: UITextField...) {
//        textFields.forEach { textField in
//            switch textField {
//            case redTextField:
//                redSlider.setValue(<#T##value: Float##Float#>, animated: <#T##Bool#>)
//            case greenTextField:
//                //greenTextField.text = greenLabel.text
//                greenSlider.value = Float(greenTextField.text!) ?? 0
//            default:
//               // blueTextField.text = blueLabel.text
//                blueSlider.value = Float(blueTextField.text!) ?? 0
//            }
//        }
//    }
    
    @IBAction func pressedDoneButton() {
        delegate.setViewColor(colorSettingsView.backgroundColor)
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    
}


extension SettingsViewController: UITextFieldDelegate {
    


    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       // return true
    }
    
    
    
    
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let newString = textField.text?.replacingCharacters(in: range, with: string), let newDouble = Double(newString) {
//            if newDouble >= 0 && newDouble <= 1 {
//                return true
//            } else {
//                showAlert(title: "error", message: "dfghjk")
//                return false
//            }
//        }
//        return false
//    }
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        if (textField == redTextField) || (textField == greenTextField) || (textField == blueTextField) {
    //            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: textField, action: #selector(resignFirstResponder))
    //            navigationItem.rightBarButtonItem = doneButton
    //        }
    //    }
    //
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //        switch textField {
    //        case redTextField:
    //            redSlider.value = Float(redTextField.text!)!
    //            setValueForLabels(redLabel)
    //        case greenTextField:
    //            greenSlider.value = Float(greenTextField.text!)!
    //            setValueForLabels(greenLabel)
    //        default:
    //            blueSlider.value = Float(blueTextField.text!)!
    //            setValueForLabels(blueLabel)
    //        }
    //}
}
