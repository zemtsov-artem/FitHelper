//
//  TheExercise.swift
//  FitHelper
//
//  Created by артем on 05.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit
import AudioToolbox


class TheExercise: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var exerciseName: UITextField!
    @IBOutlet weak var exerciseMuscleGroup: UITextField!
    @IBOutlet weak var exerciseWeight: UITextField!
    @IBOutlet weak var exerciseRepeateNumber: UITextField!
    @IBOutlet weak var exerciseSeries: UITextField!
    @IBOutlet weak var exerciseInterval: UITextField!
    @IBOutlet weak var exerciseSpecification: UITextView!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    
    var parentViewCellIndex:Int?
    var isNewExercise:Bool?
    //list of exercises with similar names
    private var listOfExercises:[Exercise] = []
    private var allExercises:[Exercise] = []
    
    //local exercise
    var currentExercise:Exercise!
    private var image:UIImage!
    
    private let exercisesGroupNames = ["Трапеции","Плечи","Бицепс","Грудь","Предплечья",
                               "Пресс","Квадрицепсы","Трицепс","Широчайшие","Средние спинные",
                               "Нижние спинные","Ягодицы","Бедра","Икры"]
    
    //Save click
    @IBAction func saveIsClicked(_ sender: Any) {
        view.endEditing(true)
        if needInAlertCheck(input: exerciseRepeateNumber) || needInAlertCheck(input: exerciseSeries) {
            showAlertWithVibration()
        }
        else {
            sendDataFromFieldsToCoreData()
            self.navigationController?.popViewController(animated: true)   
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.view.endEditing(true)
    }
    
    @objc private func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Image"), style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItems = [myBackButton]
        
        //picker view
        let muscleGroupPicker = UIPickerView()
        muscleGroupPicker.delegate = self
        exerciseMuscleGroup.inputView = muscleGroupPicker
        
        //add gesture recognizer
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeybord(recognizer:)))
        tapScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapScreen)
        
        
        
        //get from previuse view by prepare
        if ( (isNewExercise == nil) || (isNewExercise! == false) ){
            exerciseImage.image = getImageByMuscleGroupName(muscleGroupname: currentExercise.muscleGroup!)
            exerciseInterval.text = String(currentExercise.interval)
            exerciseName.text = currentExercise.exerciseName
            exerciseWeight.text = String(currentExercise.weight)
            exerciseRepeateNumber.text = String(currentExercise.repeateNumber)
            exerciseSpecification.text = currentExercise.specification
            exerciseSeries.text = String(currentExercise.series)
            exerciseMuscleGroup.text = currentExercise.muscleGroup
            listOfExercises = Exercise.getCurrentExercise(inputExercise: currentExercise)
        } else {
            exerciseImage.image = getImageByMuscleGroupName(muscleGroupname: "default")
            exerciseInterval.text = ""
            exerciseName.text = ""
            exerciseWeight.text = ""
            exerciseRepeateNumber.text = ""
            exerciseSpecification.text = ""
            exerciseSeries.text = ""
            exerciseMuscleGroup.text = ""
            //default value 
            listOfExercises = Exercise.getCurrentExercise(inputExercise: currentExercise)
          
        }
        exerciseMuscleGroup.addTarget(self, action: #selector(updateImage), for: .editingDidEnd)
        
        //Save context
        allExercises = Exercise.allExercises()
    }
    
    
    func updateImage(){
        exerciseImage.image = getImageByMuscleGroupName(muscleGroupname: exerciseMuscleGroup.text!)
    }
    //Tap recognizer
    func dismissKeybord(recognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    //Picker functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercisesGroupNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercisesGroupNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exerciseMuscleGroup.text = exercisesGroupNames[row]
    }
    
    private func sendDataFromFieldsToCoreData(){
        let currentExerciseFromCoreData:Exercise?
        if parentViewCellIndex == nil{
            currentExerciseFromCoreData = listOfExercises.last
        } else {
            currentExerciseFromCoreData = allExercises[parentViewCellIndex!]
        }
        
        //check name
        if ( (exerciseName.text != nil) && (exerciseName.text != "" ) ){
            currentExerciseFromCoreData?.setValue(exerciseName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "exerciseName")
        } else {
            currentExerciseFromCoreData?.setValue(currentExercise.exerciseName?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "exerciseName")
        }
        //check interval
        if ( (exerciseInterval.text != nil) && (exerciseInterval.text != "" ) ){
            currentExerciseFromCoreData?.setValue(getInt16FromString(exerciseInterval.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)), forKey: "interval")
        } else{
            currentExerciseFromCoreData?.setValue(currentExercise.interval, forKey: "interval")
        }
        //check weight
        if ( (exerciseWeight.text != nil) && (exerciseWeight.text != "" ) ){
            currentExerciseFromCoreData?.setValue(getInt16FromString(exerciseWeight.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)), forKey: "weight")
        }else{
            currentExerciseFromCoreData?.setValue(currentExercise.weight, forKey: "weight")
        }
        //check repeate number
        if ( (exerciseRepeateNumber.text != nil) && (exerciseRepeateNumber.text != "" )){
            currentExerciseFromCoreData?.setValue(getInt16FromString(exerciseRepeateNumber.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)), forKey: "repeateNumber")
        }else{
            currentExerciseFromCoreData?.setValue(currentExercise.repeateNumber, forKey: "repeateNumber")
        }
        //check specification
        if ( (exerciseSpecification.text != nil) && (exerciseSpecification.text != "" ) ){
            currentExerciseFromCoreData?.setValue(exerciseSpecification.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "specification")
        }else{
            currentExerciseFromCoreData?.setValue(currentExercise.specification, forKey: "specification")
        }
        //check series
        if ( (exerciseSeries.text != nil) && (exerciseSeries.text != "" ) ){
            currentExerciseFromCoreData?.setValue(getInt16FromString(exerciseSeries.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)), forKey: "series")
        }else{
            currentExerciseFromCoreData?.setValue(currentExercise.series, forKey: "series")
        }
        //check muscle group
        if ( (exerciseMuscleGroup.text != nil) && (exerciseMuscleGroup.text != "" ) ){
            currentExerciseFromCoreData?.setValue(exerciseMuscleGroup.text, forKey: "muscleGroup")
        }else{
            currentExerciseFromCoreData?.setValue(currentExercise.muscleGroup, forKey: "muscleGroup")
        }
        //save context and go back
        CoreDataHelper.instance.save()
    }
    
    private func showAlertWithVibration(){
        let alert = UIAlertController(title: "Неверные данные", message: "Повторений и подходов должно быть больше нуля", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    private func needInAlertCheck(input:UITextField?) ->Bool{
        if let text = input?.text{
            if getInt16FromString(text) < 1{
                return true
            }
        }
        return false
    }
    
    
    

   
}
