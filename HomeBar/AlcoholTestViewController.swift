//
//  AlcoholTestViewController.swift
//  HomeBar
//
//  Created by Aleksandr Mayyura on 25.10.2022.
//

import UIKit

class AlcoholTestViewController: UIViewController {
    
    @IBOutlet var drinkPickerView: UIPickerView!
    @IBOutlet var volumeSlider: UISlider! {
        didSet {
            volumeSlider.minimumValue = 0
            volumeSlider.maximumValue = 3000
        }
    }
    @IBOutlet var sexSegmentControl: UISegmentedControl!

    @IBOutlet var weightTextfield: UITextField!
    @IBOutlet var volumeTextfield: UITextField!
    
    @IBOutlet var volumeLabel: UILabel!

    @IBOutlet var userStackView: UIStackView!
    @IBOutlet var drinkStackView: UIStackView!
    
    @IBOutlet var backButton: UIBarButtonItem!
    
    private let ingredients = Drink.getIngredients()
    
    private var widmarkDistribution = 0.7
    private var weightValue = 0.0
    private var alcoholValue = 0.0
    private var weightDrink = 0.0
    private var result = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkStackView.isHidden = true
        isHiddenButton(true, .black)
        
        drinkPickerView.dataSource = self
        drinkPickerView.delegate = self
        
        weightTextfield.delegate = self
        volumeTextfield.delegate = self
        
        alcoholValue = Double(ingredients.first?.alcohol ?? 0)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultTestViewController else { return }
        resultVC.result = result
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @IBAction func backButtonTapped() {
        for stackView in [userStackView, drinkStackView] {
            stackView?.isHidden.toggle()
        }
        isHiddenButton(true, .black)
        
    }
    
    @IBAction func chooseGenderFrom() {
        switch sexSegmentControl.selectedSegmentIndex {
        case 0: widmarkDistribution = 0.7
        default:
            widmarkDistribution = 0.6
        }
    }
    
    @IBAction func hungrySwitch(_ sender: UISwitch) {
        if sender.isOn {
            widmarkDistribution += 0.1
        } else {
            widmarkDistribution -= 0.1
        }
    }
    
    @IBAction func sliderAction() {
        volumeLabel.text = "\(String(format: "%.0f", volumeSlider.value)) мл."
        volumeTextfield.text = "\(String(format: "%.0f", volumeSlider.value))"
        weightDrink = Double(volumeSlider.value)
    }
    
    @IBAction func nextButtonTapped() {
        for stackView in [userStackView, drinkStackView] {
            stackView?.isHidden.toggle()
        }
        isHiddenButton(false, UIColor(red: 1, green: 0.216, blue: 0.373, alpha: 1))
    }
    
    @IBAction func calculateTestResults() {
        let distributionUser = weightValue * widmarkDistribution
        let multipleAlcohol = weightDrink * alcoholValue
        
        if distributionUser > 0 && multipleAlcohol > 0 {
            result = multipleAlcohol / distributionUser
        } else {
            showAlert(
                title: "Вы забыли заполнить все поля 🥹",
                message: "Наверное вы уже выпили 🍾"
            )
            return
        }
     }
}

// MARK: Private methods
extension AlcoholTestViewController {
    
    private func isHiddenButton(_ isHidden: Bool, _ color: UIColor) {
        if #available(iOS 16.0, *) {
            backButton.isHidden = isHidden
        } else {
            backButton.tintColor = color
            backButton.isEnabled.toggle()
        }
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: UITextField Delegate
extension AlcoholTestViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
          
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()

        textField.inputAccessoryView = keyboardToolbar

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField == weightTextfield {
            guard let currentValue = Float(text), (0...300).contains(currentValue) else {
                showAlert(
                    title: "Ошибка",
                    message: "Введите число от 0 до 300",
                    textField: textField
                )
                return
            }
            weightValue = Double(currentValue)
        } else {
            guard let volumeValue = Float(text), (0...3000).contains(volumeValue) else {
                showAlert(
                    title: "Ошибка",
                    message: "Введите число от 0 до 3000",
                    textField: volumeTextfield
                )
                return
            }
            volumeSlider.setValue(volumeValue, animated: true)
            volumeLabel.text = "\(String(format: "%.0f", volumeValue)) мл."
            weightDrink = Double(volumeValue)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false}
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        if textField == weightTextfield {
            return newText.count < 4
        } else {
            return newText.count < 5
        }
    }
}

// MARK: UIPickerView Data Source
extension AlcoholTestViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ingredients.count
    }
}

// MARK: UIPickerView Delegate
extension AlcoholTestViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: ingredients[row].name)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        alcoholValue = Double(ingredients[row].alcohol)
        print(alcoholValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = ingredients[row].name

        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}

