//
//  ExerciseCell.swift
//  FitHelper
//
//  Created by артем on 05.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var muscleGroup: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
