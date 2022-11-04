//
//  ViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var agePicker: UIDatePicker!

    override func viewWillLayoutSubviews() {
        agePicker.setValue(UIColor.white, forKey: "backgroundColor")
        agePicker.layer.cornerRadius = 10
        agePicker.layer.masksToBounds = true
    }

    @IBAction func confirmAge() {
        let numberOfYears = Calendar.current.dateComponents(
            [.year],
            from: agePicker.date,
            to: Date.now
        ).year
        if numberOfYears ?? 0 >= 18 {
            performSegue(withIdentifier: "showIngredients", sender: nil)
        } else {
            showAlert(
                title: "Отказано в доступе!",
                message: "Вам не исполнилось 18 лет! 🥃"
            )
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
