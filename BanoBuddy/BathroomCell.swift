//
//  BathroomCell.swift
//  BanoBuddy
//
//  Created by Jianyi Gao 高健一 on 3/20/17.
//  Copyright © 2017 BanoBuddy. All rights reserved.
//

import UIKit
import Parse

class BathroomCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var thumbNail: UIImageView!
    
    var bathroom: PFObject?{
        didSet {
            print("Bathroom object has now been set!")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
