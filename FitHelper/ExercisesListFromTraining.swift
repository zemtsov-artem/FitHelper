//
//  ExercisesListFromTraining.swift
//  FitHelper
//
//  Created by артем on 05.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class ExercisesListFromTraining: UITableViewController,passDataToConnectDelegate {
    var exerciseList:[Exercise] = []
    var currentTraining:Training!
    
    //realise delegate method to get data from child
    func getSelectedExercises(inputExercises:[Exercise])
    {
        exerciseList = inputExercises
    }

    @IBAction func SaveListOfExercises(_ sender: Any) {
        if let theTrainingFromCoreData = Training.getCurrentTraining(inputTraining: currentTraining).last {
            let setOfExercises:NSOrderedSet = NSOrderedSet(array: exerciseList)
            theTrainingFromCoreData.setValue(setOfExercises, forKey: "exercise")
            CoreDataHelper.instance.save()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc private func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Image"), style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItems = [myBackButton]
        //mark all exercises
        exerciseList = Array(currentTraining.exercise!) as! [Exercise]
        self.tableView.isEditing = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        if exerciseList.count != 0{
            cell.exerciseName?.text = exerciseList[indexPath.row].exerciseName
            cell.muscleGroup?.text = "Группа мыщц: " + exerciseList[indexPath.row].muscleGroup!
            cell.exerciseImage?.image = getImageByMuscleGroupName(muscleGroupname: exerciseList[indexPath.row].muscleGroup!)
            return cell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            let movedObject = self.exerciseList[fromIndexPath.row]
            exerciseList.remove(at: fromIndexPath.row)
            exerciseList.insert(movedObject, at: to.row)
    }
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ExercisesList
        destination.delegate = self
        destination.exerciseFromTraining = exerciseList
    }
 

}
