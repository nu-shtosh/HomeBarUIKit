//
//  DeveloperDetailsViewController.swift
//  HomeBar
//
//  Created by Armen Madoyan on 30.10.2022.
//

import UIKit

class DeveloperDetailsViewController: UIViewController {

    @IBOutlet var infoTextView: UITextView!
    
    @IBOutlet var developImageView: UIImageView!
    
    var devInfo: Developer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = devInfo.fullname
        infoTextView.text = devInfo.info
        developImageView.image = UIImage(named: devInfo.photo)
    }
    
    override func viewDidLayoutSubviews() {
        developImageView.layer.cornerRadius = 10
    }
}
