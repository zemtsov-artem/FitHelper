//
//  TrainingsList.swift
//  FitHelper
//
//  Created by артем on 10.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit



class TrainingsList: UITableViewController {
    var trainingData:[Training] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        trainingData = Training.allTrainings()
    }
    override func viewDidAppear(_ animated: Bool) {
        trainingData = Training.allTrainings()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trainingCell", for: indexPath)
        
        cell.textLabel?.text = trainingData[indexPath.row].trainingName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndexPath:IndexPath = IndexPath(item: indexPath.row, section: 0)
        performSegue(withIdentifier: "goToTheTrainingFromList", sender: myIndexPath)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TrainingPage {
            let backItem = UIBarButtonItem()
            backItem.title = " "
            backItem.image = #imageLiteral(resourceName: "Image")
            navigationItem.backBarButtonItem = backItem
            
            
            if (segue.identifier == "createNewTraining"){
                var _ :Training = Training(desiredDay: "Понедельник", specification: "Описание тренировки", trainingName: "Название тренировки", trainingType: "")
                CoreDataHelper.instance.save()
                
                destination.currentTraining = Training.allTrainings().last
                
                
            }
            if (segue.identifier == "editTraining"){
                let pathIndex = sender!
                destination.currentTraining = trainingData[(pathIndex as AnyObject).row]
                
            }
            
        }
        if let destination = segue.destination as? listOfExercisesInActivityTraining{
            if segue.identifier == "goToTheTrainingFromList"{
                let pathIndex = sender!
                destination.currentTraining = trainingData[(pathIndex as AnyObject).row]
                
        }

        }
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Изменить"){ (UITableViewRowAction, NSIndexPath) in
            self.performSegue(withIdentifier: "editTraining", sender: indexPath)
        }
        editAction.backgroundColor = .lightGray
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить"){(UITableViewRowAction, NSIndexPath) in
            // Delete the row from the data source
            // delete data from core data
            CoreDataHelper.instance.context.delete(self.trainingData[indexPath.row])
            CoreDataHelper.instance.save()
            //reload class data
            self.trainingData = Training.allTrainings()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction,editAction]
    }
}
