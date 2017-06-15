//
//  finalizeActivityTraining.swift
//  FitHelper
//
//  Created by артем on 07.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class finalizeActivityTraining: UIViewController {

    @IBOutlet weak var finilisedSeriesNum: UILabel!
    @IBOutlet weak var finilisedExercisesNum: UILabel!
    @IBOutlet weak var timeSeconds: UILabel!
    @IBOutlet weak var timeMinutes: UILabel!
    @IBOutlet weak var allFinilisedWeight: UILabel!
    @IBOutlet weak var secondsDescription: UILabel!
    
    @IBAction func endTrainingIsClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private let secondsInOneMin:Int = 60
    var finalisedTraining:FinalisedTraining!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        var SeriesNumSum = 0
        var allWeight = 0
        
//        finalisedTraining = FinalisedTraining.allFinalisedTrainings().last!
        if let finilisedExercisesInTraining = finalisedTraining.finalisedExercises {
            finilisedExercisesNum.text = String(finilisedExercisesInTraining.count)
            for item  in finilisedExercisesInTraining{
                if let exercise = item as? FinalisedExercise{
                    SeriesNumSum += (exercise.seriesWeightValues?.count)!
                    for value in exercise.seriesWeightValues!{
                        allWeight += Int(value)
                    }
                }
            }
            finilisedSeriesNum.text = String(SeriesNumSum)
            allFinilisedWeight.text = String(allWeight)
            let timeInteval  = Int(finalisedTraining.time)
            if (timeInteval % secondsInOneMin) == 0 {
                timeSeconds.isHidden = true
                secondsDescription.isHidden = true
            } else {
                timeSeconds.text = String(timeInteval % secondsInOneMin)
            }
            timeMinutes.text = String(Int(timeInteval / secondsInOneMin))
            
            
        } else {
            finilisedExercisesNum.text = "0"
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
