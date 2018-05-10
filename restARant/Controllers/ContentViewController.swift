//
//  ContentViewController.swift
//  restARant
//
//  Created by Patrick Maribojoc on 5/9/18.
//  Copyright © 2018 PatrickMaribojoc. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var type: ContentType = .Music
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ContentViewController viewDidLoad");
        print(type.rawValue);
        imageView.image = UIImage(named: type.rawValue)
    }
    
}
