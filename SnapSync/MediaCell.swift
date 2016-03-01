//
//  MediaCell.swift
//  SnapSync
//
//  Created by DGh0st on 2/29/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit
import Parse

class MediaCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var mediaImage: UIImageView!
    
    var media: PFObject! {
        didSet {
            captionLabel.text = media.valueForKey("caption") as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
