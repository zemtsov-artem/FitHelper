//
//  TrashTVC.swift
//  FitHelper
//
//  Created by артем on 04.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class ExercisesList: UITableViewController {

    var exercisesData : [Exercise] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisesData = Exercise.allExercises()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print ("I am in did appear")
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
        //return exercisesData.count
        return Exercise.allExercises().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        //font
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        //Exercise data
        cell.exerciseName?.text = exercisesData[indexPath.row].exerciseName
        cell.muscleGroup?.text = exercisesData[indexPath.row].muscleGroup
        //Here i can add image check
        cell.exerciseImage?.image = #imageLiteral(resourceName: "Good")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TheExercise {
            let backItem = UIBarButtonItem()
            backItem.title = "Список упражнений"
            navigationItem.backBarButtonItem = backItem
            if segue.identifier == "fromListToExercise"{
                if let path = tableView.indexPathForSelectedRow {
                    destination.currentExercise = exercisesData[path.row]
                    destination.image = #imageLiteral(resourceName: "Good")
                }
            }else{
                if segue.identifier == "addExercise"{
                    var _:Exercise = Exercise( name: "",
                                                    specification:"",
                                                    weigth: 0,
                                                    interval: 0,
                                                    muscleGroup: "",
                                                    repeateNumber: 0,
                                                    series:0
                    )
                    CoreDataHelper.instance.save()
                    print ("AFTER")
                    for iter in Exercise.allExercises(){
                        showExercise(exercise: iter)
                    }
                    //something to fix
                    destination.currentExercise = Exercise.allExercises().last
                    destination.image = #imageLiteral(resourceName: "Good")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //myData.remove(at: indexPath.row)
            print (CoreDataHelper.instance.allObjectsFromContext().count )
            CoreDataHelper.instance.context.delete(exercisesData[indexPath.row])
            CoreDataHelper.instance.save()
            print (CoreDataHelper.instance.allObjectsFromContext().count )
            //tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
}