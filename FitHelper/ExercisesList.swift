//
//  TrashTVC.swift
//  FitHelper
//
//  Created by артем on 04.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit


protocol passDataToConnectDelegate {
    func getSelectedExercises(inputExercises:[Exercise])
}

class ExercisesList: UITableViewController,UIPopoverPresentationControllerDelegate {
    
    var delegate:passDataToConnectDelegate?

    //all exercises
    var exercisesData : [Exercise] = []
    
    var exerciseFromTraining:[Exercise] = []
    var indexOfExercisesToSend:[Int] = []
    var exerciseToSend : [Exercise] = []

    @IBAction func sendDataToConnectController(_ sender: Any) {

        for item in 0..<indexOfExercisesToSend.count {
            exerciseToSend.append(exercisesData[indexOfExercisesToSend[item]])
        }
        self.delegate?.getSelectedExercises(inputExercises: exerciseToSend)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisesData = Exercise.allExercises()
        self.navigationItem.hidesBackButton = true
        fromExerciseListToIndexList(inputExerciseList: exerciseFromTraining)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        garbageCollector()
        exercisesData = Exercise.allExercises()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Exercise.allExercises().count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let indexToRemove = tryToGetIndexOfExerciseInSelectedData(indexPath.row){
                indexOfExercisesToSend.remove(at: indexToRemove)
                
            }
           
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            indexOfExercisesToSend.append(indexPath.row)
            

        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        //font
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        //Exercise data
        cell.exerciseName?.text = exercisesData[indexPath.row].exerciseName
        cell.muscleGroup?.text = "Группа мыщц: " + exercisesData[indexPath.row].muscleGroup!
        cell.exerciseImage?.image = getImageByMuscleGroupName(muscleGroupname: exercisesData[indexPath.row].muscleGroup!)
        if (tryToGetIndexOfExerciseInSelectedData(indexPath.row) != nil){
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? TheExercise {
            let backItem = UIBarButtonItem()
            backItem.title = "Список упражнений"
            navigationItem.backBarButtonItem = backItem
            
            if segue.identifier == "fromEditToChange"{
                // some fast and dirty
                let pathIndex = sender!
                destination.parentViewCellIndex = (pathIndex as AnyObject).row
                destination.currentExercise = exercisesData[(pathIndex as AnyObject).row]
                
            }
            if segue.identifier == "addExerciseByCellButton"{
                    var _:Exercise = Exercise( name: "Название упражнения",
                                                    specification:"Описание",
                                                    weight: 0,
                                                    interval: 0,
                                                    muscleGroup: "Мышечная группа",
                                                    repeateNumber: 1,
                                                    series:1
                    )
                    CoreDataHelper.instance.save()
                    destination.navigationItem.title = "Новое упражнение"
                    destination.isNewExercise = true
                    destination.currentExercise = Exercise.allExercises().last
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Изменить"){ (UITableViewRowAction, NSIndexPath) in
            self.performSegue(withIdentifier: "fromEditToChange", sender: indexPath)
        }
        editAction.backgroundColor = .lightGray
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить"){(UITableViewRowAction, NSIndexPath) in
            // Delete the row from the data source
            // delete data from core data
            CoreDataHelper.instance.context.delete(self.exercisesData[indexPath.row])
            CoreDataHelper.instance.save()
            //reload class data
            self.exercisesData = Exercise.allExercises()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction,editAction]

    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    private func fromExerciseListToIndexList(inputExerciseList:[Exercise]){
        for inputExercise in inputExerciseList{
            for exerciseIndex in 0..<exercisesData.count {
                if inputExercise == exercisesData[exerciseIndex]{
                    indexOfExercisesToSend.append(exerciseIndex)
                }
            }
        }
    }
    
    private func tryToGetIndexOfExerciseInSelectedData(_ inputIndex:Int) ->Int?{
        for index in 0..<indexOfExercisesToSend.count{
            if indexOfExercisesToSend[index] == inputIndex{
                return index
            }
        }
        return nil
    }
    
    private func garbageCollector(){
        var exerciseList:[Exercise] = Exercise.allExercises()
        var arrayOfIndexesToDelete:[Int] = []
        for number in 0..<exerciseList.count{
            var checkArray:[Exercise] = exerciseList
            checkArray.removeSubrange(0...number)
            for checkExercise in checkArray{
                if (exerciseList[number] == checkExercise) ||
                    ((exerciseList[number].exerciseName) == (checkExercise.exerciseName) && (exerciseList[number].muscleGroup) == (checkExercise.muscleGroup)){
                    arrayOfIndexesToDelete.insert(number, at: 0)
                }
            }
        }
        //
        if ( !arrayOfIndexesToDelete.isEmpty ){
            for item in 0..<arrayOfIndexesToDelete.count{
                CoreDataHelper.instance.context.delete(self.exercisesData[arrayOfIndexesToDelete[item]])
                CoreDataHelper.instance.save()
            }
        }
        
        
    }
    
    
}

