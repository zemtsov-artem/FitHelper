//
//  activityTrainingPage.swift
//  FitHelper
//
//  Created by артем on 07.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class activityTrainingPage: UIViewController {

    @IBOutlet weak var currentExerciseName: UILabel!
    @IBOutlet weak var currentExerciseImage: UIImageView!
    @IBOutlet weak var goNextButtonName: UIButton!
    @IBOutlet weak var currentExerciseWeigth: UITextField!
    @IBOutlet weak var currentExerciseRepeate: UITextField!
    private let goNextExercise:String = "К следующему упражнению"
    var isInitialised:Bool = false
    let FIRST_SERIES:Int = 1
    let FIRST_EXERCISE:Int = 0
    
    var exerciseActivitiesRepeateNumbers:[Int16] = []
    var exerciseActivitiesWeightValues:[Int16] = []
    
    var finalisedExercises:[FinalisedExercise] = []
    var finalisedTraining:[FinalisedTraining] = []
    var finalisedTrainingDataToSend:FinalisedTraining?
    var isFinished:Bool = false
    
    var currentTraining:Training!
    var currentExercise:Exercise!
    var listOfExercisesFromCurrentTraining:[Exercise]!
    
    private var currentSeriesNumber:Int?
    private var exerciseNum:Int!
    private var seriesNumber:Int!
    private var currentExerciseNumber:Int!
    
    var startExerciseTime : NSDate!
    var startTrainingTime : NSDate!
    
    
    
    @IBAction func plusWeight(_ sender: Any) {
        makeOperationWithTextField(textField: currentExerciseWeigth, operation: "inc")
    }
    
    @IBAction func minusWeight(_ sender: Any) {
        makeOperationWithTextField(textField: currentExerciseWeigth, operation: "dec")
    }
    
    @IBAction func minusRepeate(_ sender: Any) {
        makeOperationWithTextField(textField: currentExerciseRepeate, operation: "dec")
    }
    
    @IBAction func plusRepeate(_ sender: Any) {
        makeOperationWithTextField(textField: currentExerciseRepeate, operation: "inc")
    }
    
    
    @IBAction func goNextButtonIsClicked(_ sender: Any) {
        //save in global coredata
        //update exercise data in training
        saveRepeateNumberAndWeight()
        updateTheFrame()
        initTextFields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTrainingTime = NSDate()
        let myLeftBarButtonWhichFinish = UIBarButtonItem(image: #imageLiteral(resourceName: "finalFlag"), style: .plain, target: self, action: #selector(finishNow))
        
        self.navigationItem.leftBarButtonItems = [myLeftBarButtonWhichFinish]
        exerciseNum = currentTraining.exercise?.count
        listOfExercisesFromCurrentTraining = Array(currentTraining.exercise!) as! [Exercise]
        currentExercise = listOfExercisesFromCurrentTraining.first
        initMetaData()
        initTextFields()
        //set it to check in methods something what should we do once
        isInitialised = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func updateTheFrame(){
        if currentSeriesNumber == seriesNumber {
            //Go to the next exercise
            updateToTheNextExercise()
        }
        else {
            goToTheNextSeries()
            
        }
    }
    
    private func initTextFields(){
        currentExerciseName.text = currentExercise.exerciseName
        currentExerciseImage.image = getImageByMuscleGroupName(muscleGroupname: currentExercise.muscleGroup!)
        currentExerciseWeigth.text =  String(currentExercise.weight)
        currentExerciseRepeate.text = String(currentExercise.repeateNumber)
    }
    
    
    private func initMetaData(){
        if  !isInitialised {
            startExerciseTime = NSDate()
            exerciseActivitiesRepeateNumbers = []
            exerciseActivitiesWeightValues = []
            
        }
        
        
        if currentExerciseNumber == nil{
            currentExerciseNumber = FIRST_EXERCISE
        }
        seriesNumber = Int(currentExercise.series)
        currentSeriesNumber = FIRST_SERIES
        goNextButtonName.setTitle(createTextForButtonToNextSeries(buttonType:"nextSeries"), for: .normal)
    }
    
    private func cleanFieldsOfTheWhitespaces(inputArray:[UITextField]){
        for textField in inputArray {
            textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private func saveRepeateNumberAndWeight() {
        cleanFieldsOfTheWhitespaces( inputArray: [ currentExerciseWeigth,currentExerciseRepeate] )
        if currentExerciseWeigth.text != "" && currentExerciseWeigth != nil {
            if currentExercise.weight != Int16(currentExerciseWeigth.text!)!{
                let newCurrentExercise = Exercise.getCurrentExercise(inputExercise: currentExercise)
                newCurrentExercise.first?.weight = (Int16(currentExerciseWeigth.text!)!)
                currentExercise = newCurrentExercise.first
                CoreDataHelper.instance.save()
            }
            exerciseActivitiesWeightValues.append(Int16(currentExerciseWeigth.text!)!)
        }
        if currentExerciseRepeate.text != "" && currentExerciseRepeate != nil {
            if currentExercise.repeateNumber != Int16(currentExerciseRepeate.text!)!{
                let newCurrentExercise = Exercise.getCurrentExercise(inputExercise: currentExercise)
                newCurrentExercise.first?.repeateNumber = (Int16(currentExerciseRepeate.text!)!)
                currentExercise = newCurrentExercise.first
                CoreDataHelper.instance.save()
            }
            exerciseActivitiesRepeateNumbers.append(Int16(currentExerciseRepeate.text!)!)
        }
        
    }
    
    @objc private func finishNow(){
        isFinished = true
        updateToTheNextExercise()
    }
    
    @objc private func updateToTheNextExercise() {
        let timeInterval = Int16(Date().timeIntervalSince(startExerciseTime as Date))
        if exerciseActivitiesWeightValues.count > 0 && exerciseActivitiesRepeateNumbers.count > 0 {
            let finalisedActivity :FinalisedExercise = FinalisedExercise(name: currentExercise.exerciseName!,
                                                                         time: timeInterval, seriesWeightValues: exerciseActivitiesWeightValues,
                                                                         seriesRepeateValues: exerciseActivitiesRepeateNumbers)
            finalisedExercises.append(finalisedActivity)
            
            CoreDataHelper.instance.save()
        }
        
        if currentExercise == listOfExercisesFromCurrentTraining.last || isFinished {
            //Finish training
            finishTraining()
        }else {
            currentExerciseNumber = currentExerciseNumber + 1
            currentExercise = listOfExercisesFromCurrentTraining[currentExerciseNumber]
            isInitialised = false
            initMetaData()

        }
    }
    

    
    private func goToTheNextSeries() {
        currentSeriesNumber = currentSeriesNumber! + 1
        if currentSeriesNumber == seriesNumber{
            if currentExercise == listOfExercisesFromCurrentTraining.last{
                goNextButtonName.setTitle(createTextForButtonToNextSeries(buttonType:"def"), for: .normal)
            } else {
                goNextButtonName.setTitle(createTextForButtonToNextSeries(buttonType:"nextExercise"), for: .normal)
            }
        } else {
            goNextButtonName.setTitle(createTextForButtonToNextSeries(buttonType:"nextSeries"), for: .normal)
        }
        
    
    }
    
    private func createTextForButtonToNextSeries(buttonType:String) -> String{
        switch buttonType {
        case "nextSeries":
            //+1 cause it is next
            return "Перейти к " + String(currentSeriesNumber! + 1) + " подходу"
        case "nextExercise":
            return "Перейти к следующему упражнению"
        default:
            return "Закончить тренировку"
        }
        
    }
    
    private func makeOperationWithTextField(textField:UITextField,operation:String){
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        switch operation {
        case "dec":
            if (Int(textField.text!) == nil || textField.text == "" ){
                textField.text = "0"
            } else {
                if let text = Int(textField.text!){
                    if text > 1 {
                        textField.text = String(text - 1)
                    } else {
                        textField.text = "0"
                    }
                } else {
                    textField.text = "0"
                }
            }
        case "inc":
            if (Int(textField.text!) == nil || textField.text == "" ){
                textField.text = "0"
            } else {
                if let text = Int(textField.text!){
                    textField.text = String(text + 1)
                }
            }
            
        default:
            break
        }
    }
    
    @objc private func finishTraining(){
        let NSSETValue  = NSSet(array: finalisedExercises)
        let timeInterval = Int16(Date().timeIntervalSince(startTrainingTime as Date))
        startTrainingTime = NSDate()
        let newVar :FinalisedTraining = FinalisedTraining(date: NSDate(), name: currentTraining.trainingName!,
                                                  time:timeInterval , finalisedExercises: NSSETValue )
        finalisedTrainingDataToSend = newVar
        finalisedExercises = []
        performSegue(withIdentifier: "goToTheFinalScreen", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? finalizeActivityTraining{
            if segue.identifier == "goToTheFinalScreen"{
                destination.finalisedTraining = finalisedTrainingDataToSend
        }
    }
}

    

}
