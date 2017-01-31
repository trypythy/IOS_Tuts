//
//  EditProfileViewController.swift
//  wip_meenagram
//
//  Created by Ameenah Burhan on 1/30/17.
//  Copyright © 2017 Meena LLC. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var displayNameText: UITextField!
    @IBOutlet weak var bioText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func changePhotoButton(_ sender: Any) {
    }
    
}
