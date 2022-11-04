//
//  ResultTestViewController.swift
//  HomeBar
//
//  Created by Aleksandr Mayyura on 27.10.2022.
//

import UIKit

class ResultTestViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var motivatingLabel: UILabel!
    
    @IBOutlet var resulImageView: UIImageView!
    
    var result = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Уровень алкоголя в крови составляет примерно \(round(result * 100)/100) промилле."
        showMotivating()
    }
    
    private func showMotivating() {
        switch result {
        case 0...0.16:
            motivatingLabel.text = "Похоже, что вечеринка только началась. Оставьте ключи от машины и развлекайтесь."
            resulImageView.image = UIImage(named: "5.png")
        case 0.16...1.5:
            motivatingLabel.text = "У Вас легкое опьянение. Возможно, стоит остановиться и выпить крепкого кофе."
            resulImageView.image = UIImage(named: "6.png")
        case 1.5...2.7:
            motivatingLabel.text = "Вы уже изрядно пьяны. Вызывайте такси и ложитесь спать, за этот совет завтра Вы скажите \"Спасибо\"!"
            resulImageView.image = UIImage(named: "4.png")
        case 2.7...3.7:
            motivatingLabel.text = "Вы очень сильно пьяны. Надеемся, Вы еще можете читать. Попросите помощи, чтобы добраться до дома."
            resulImageView.image = UIImage(named: "8.png")
        default:
            motivatingLabel.text = "Надеемся, что Вы живы."
            resulImageView.image = UIImage(named: "3.png")
        }
    }
}
