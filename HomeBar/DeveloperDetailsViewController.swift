//
//  DeveloperDetailsViewController.swift
//  HomeBar
//
//  Created by Armen Madoyan on 30.10.2022.
//

import UIKit

class DeveloperDetailsViewController: UIViewController {

    @IBOutlet var infoTextView: UITextView!
    
    var devInfo: Developer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = devInfo.fullname
        infoTextView.text = devInfo.info
    }
}
