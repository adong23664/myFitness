//
//  BodyTableViewCell.swift
//  myFitness
//
//  Created by 楊振東 on 2021/6/2.
//

import UIKit

class ChestTableViewCell: UITableViewCell {
    
    @IBOutlet var chestNameLabel: UILabel!
    @IBOutlet var chestImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
