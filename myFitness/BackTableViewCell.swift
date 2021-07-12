//
//  BackTableViewCell.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/6.
//

import UIKit

class BackTableViewCell: UITableViewCell {
    
    @IBOutlet var backNameLabel: UILabel!
    @IBOutlet var backImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
