//
//  TrainingCell.swift
//  FitHelper
//
//  Created by артем on 04.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class TrainingCell: UITableViewCell {

    @IBOutlet weak var TrainingName: UILabel!
    @IBOutlet weak var MuscleGroup: UILabel!
    @IBOutlet weak var DayOfTheWeek: UILabel!
    @IBOutlet weak var TrainingImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
