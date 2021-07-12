//
//  AllTableViewCell.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit

class ShoulderTableViewCell: UITableViewCell {
    @IBOutlet var shoulderNameLabel: UILabel!
    @IBOutlet var shoulderImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
