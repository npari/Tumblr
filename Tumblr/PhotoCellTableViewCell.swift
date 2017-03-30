//
//  PhotoCellTableViewCell.swift
//  Tumblr
//
//  Created by Pari, Nithya on 3/29/17.
//  Copyright © 2017 Pari, Nithya. All rights reserved.
//

import UIKit

class PhotoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
