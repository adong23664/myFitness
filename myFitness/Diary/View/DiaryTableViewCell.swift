//
//  DiaryTableViewCell.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/10.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var thumbnailImageVew: UIImageView!
    @IBOutlet var heartImageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
