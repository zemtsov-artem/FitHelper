//
//  TrainingPage.swift
//  FitHelper
//
//  Created by артем on 28.04.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

protocol editTrainingDelegate{
    func getRenovatedTraining(renovatedTraining:Training)
}


class TrainingPage: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegate:editTrainingDelegate?
    private var allTrainings:[Training] = []
    private var listOfTrainings:[Training] = []
    var currentTraining:Training!
    private var isNewTraining:Bool?
    private var datePickerView:UIPickerView?
    private var trainingTypePickerView:UIPickerView?
    
    @IBOutlet weak var exerciseNum: UILabel!
    @IBOutlet weak var TrainingName: UITextField!
    @IBOutlet weak var TrainingDescription: UITextView!
    @IBOutlet weak var TrainingType: UITextField!
    @IBOutlet weak var TrainingDay: UITextField!
    @IBAction func CreateButtonIsClicked(_ sender: Any) {
        getDataFromUser()
        
        if ( (self.previousViewController as? listOfExercisesInActivityTraining) != nil) {
            self.delegate?.getRenovatedTraining(renovatedTraining: currentTraining)
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    private let dayPickOption = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    private let trainingTypePickOption = ["Силовая","Кардио"]
    
    
  
    
    @objc private func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Image"), style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItems = [myBackButton]
        datePickerView = UIPickerView()
        trainingTypePickerView = UIPickerView()
        
        datePickerView?.delegate = self
        trainingTypePickerView?.delegate = self
        
        TrainingType.inputView = trainingTypePickerView
        TrainingDay.inputView = datePickerView
        
        //Core Data
        listOfTrainings = Training.getCurrentTraining(inputTraining: currentTraining)
        //Set text fields
        TrainingName.text = currentTraining.trainingName
        TrainingDescription.text = currentTraining.specification
        TrainingType.text = currentTraining.trainingType
        TrainingDay.text = currentTraining.desiredDay
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeybord(recognizer:)))
        tapScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapScreen)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        exerciseNum.text = String(describing: Training.getCurrentTraining(inputTraining: currentTraining).first!.exercise!.count)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if TrainingDay.inputView == pickerView{
            return dayPickOption.count
        } else {
            return trainingTypePickOption.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if TrainingDay.inputView == pickerView{
            return dayPickOption[row]
        } else {
            return trainingTypePickOption[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if TrainingDay.inputView == pickerView{
            TrainingDay.text = dayPickOption[row]
        } else {
            TrainingType.text = trainingTypePickOption[row]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        view.endEditing(true)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //Tap recognizer
    func dismissKeybord(recognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExercisesListFromTraining {
            if (segue.identifier == "addExerciseToTheTraining"){
                getDataFromUser()
                destination.currentTraining = currentTraining
                
            }
        }
        
    }
    private func getDataFromUser(){
        let currentTrainingFromCoreData = listOfTrainings[0]
        //TrainingName
        if (TrainingName.text != ""){
            currentTrainingFromCoreData.setValue(TrainingName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "trainingName")
        }
        else {
            currentTrainingFromCoreData.setValue(currentTraining.trainingName?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "trainingName")
        }
        //TrainingDescription
        if (TrainingDescription.text != ""){
            currentTrainingFromCoreData.setValue(TrainingDescription.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "specification")
        }
        else {
            currentTrainingFromCoreData.setValue(currentTraining.specification?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "specification")
        }
        // TrainingType
        if (TrainingType.text != ""){
            currentTrainingFromCoreData.setValue(TrainingType.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "trainingType")
        }
        else {
            currentTrainingFromCoreData.setValue(currentTraining.trainingType?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "trainingType")
        }
        //TrainingDay
        if (TrainingDay.text != ""){
            currentTrainingFromCoreData.setValue(TrainingDay.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "desiredDay")
        }
        else {
            currentTrainingFromCoreData.setValue(currentTraining.desiredDay?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), forKey: "desiredDay")
        }
        CoreDataHelper.instance.save()
    }

}


