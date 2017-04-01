//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Pari, Nithya on 3/31/17.
//  Copyright © 2017 Pari, Nithya. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoDetailsViewController: UIViewController {

    //public property for PhotoURL
    var imagURL: URL!
    var detailedImage: UIImage?
    
    @IBOutlet weak var photoDetailsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetailsImageView.setImageWith(imagURL)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
