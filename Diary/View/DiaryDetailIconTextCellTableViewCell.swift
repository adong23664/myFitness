//
//  DiaryDetailIconTextCellTableViewCell.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/11.
//

import UIKit

class DiaryDetailIconTextCellTableViewCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var shortTextLabel: UILabel! {
        didSet {
            shortTextLabel.numberOfLines = 0
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
