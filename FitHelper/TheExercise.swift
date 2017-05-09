//
//  TheExercise.swift
//  FitHelper
//
//  Created by артем on 05.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class TheExercise: UIViewController{
    @IBOutlet weak var exerciseInterval: UITextView!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseName: UITextView!
    @IBOutlet weak var exerciseWeight: UITextView!
    @IBOutlet weak var exerciseRepeteNumber: UITextView!
    @IBOutlet weak var exerciseSpecification: UITextView!
    @IBOutlet weak var exerciseSeries: UITextView!
    @IBAction func saveIsClicked(_ sender: Any) {
            var _:Exercise = Exercise(
                name: exerciseName.text ,
                specification:exerciseSpecification.text,
                weigth:  getInt16FromString(exerciseWeight.text),
                interval: getInt16FromString(exerciseInterval.text),
                muscleGroup: "Грудь",
                repeateNumber: getInt16FromString(exerciseRepeteNumber.text),
                series:getInt16FromString(exerciseSeries.text)
            )
            CoreDataHelper.instance.save()
    }
    
    var currentExercise:Exercise!
    var image:UIImage!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseImage.image = image
        exerciseInterval.text = String(currentExercise.interval)
        exerciseName.text = currentExercise.exerciseName
        exerciseWeight.text = String(currentExercise.weigth)
        exerciseRepeteNumber.text = String(currentExercise.repeateNumber)
        exerciseSpecification.text = currentExercise.specification
        exerciseSeries.text = String(currentExercise.series)
    }

   
}
