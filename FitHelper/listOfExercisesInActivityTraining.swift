//
//  listOfExercisesinActivityTraining.swift
//  FitHelper
//
//  Created by артем on 07.06.17.
//  Copyright © 2017 артем. All rights reserved.
//
import AudioToolbox
import UIKit

class listOfExercisesInActivityTraining: UITableViewController,editTrainingDelegate {
    
    var exercisesData : [Exercise] = []
    var exerciseFromTraining:[Exercise] = []
    var currentTraining:Training!
    
    @IBAction func startIsClicked(_ sender: Any) {
        if (currentTraining != nil) && (currentTraining.exercise?.count != 0 ){
            performSegue(withIdentifier: "goToAcitvity", sender: Any?.self)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Пустая тренировка", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let myBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Image"), style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItems = [myBackButton]
    }
    
    @objc private func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exercisesData = Array(currentTraining!.exercise! ) as! [Exercise]
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (currentTraining.exercise?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell

        //font
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        //Exercise data
        cell.exerciseName?.text = exercisesData[indexPath.row].exerciseName
        cell.muscleGroup?.text = "Группа мыщц: " + exercisesData[indexPath.row].muscleGroup!
        cell.exerciseImage?.image = getImageByMuscleGroupName(muscleGroupname: exercisesData[indexPath.row].muscleGroup!)

        return cell
    }
    
    func getRenovatedTraining(renovatedTraining:Training){
        
        self.currentTraining = renovatedTraining
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? activityTrainingPage {
            if segue.identifier == "goToAcitvity"{
                destination.currentTraining = currentTraining
            
            }
        } else {
            if let destination = segue.destination as? TrainingPage {
                if segue.identifier == "editFromActivityTraining" {
                    destination.currentTraining = currentTraining
                }
            }
        }
    }

}
