//
//  TweetTableViewCell.swift
//  Twit
//
//  Created by Muhd Mirza on 3/12/19.
//  Copyright © 2019 muhdmirzamz. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.textLabel?.frame.origin.x = self.profileImageView.frame.origin.x + (self.profileImageView.frame.size.width / 2) + 20
    }

}
