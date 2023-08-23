//
//  ActivityCellTableViewCell.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 23.08.23.
//

import UIKit

class ActivityCellTableViewCell: UITableViewCell {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DistanbeLabel: UILabel!
    @IBOutlet weak var DistanceUnitLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TimeUnitLabel: UILabel!
    @IBOutlet weak var PaceLabel: UILabel!
    @IBOutlet weak var PaceUnitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
