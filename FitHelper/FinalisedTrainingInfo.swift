//
//  FinalisedTrainingInfo.swift
//  FitHelper
//
//  Created by артем on 13.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class FinalisedTrainingInfo: UITableViewController {

    
    var currentFinalisedTraining:FinalisedTraining?
    var exercisesArray:[FinalisedExercise] = []
    
    @objc private func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Image"), style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItems = [myBackButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exercisesArray  = Array(currentFinalisedTraining!.finalisedExercises!) as! [FinalisedExercise]
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (currentFinalisedTraining?.finalisedExercises?.count)!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndexPath:IndexPath = IndexPath(item: indexPath.row, section: 0)
        performSegue(withIdentifier: "toRepeateNumberValueCell", sender: myIndexPath)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fininilisedExercisesCell", for: indexPath)
        cell.textLabel?.text = exercisesArray[indexPath.row].name
        return cell
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? repeateNumberTableView{
            if segue.identifier == "toRepeateNumberValueCell"{
                let pathIndex = sender!
                destination.currentFinalisedExercise = exercisesArray[(pathIndex as AnyObject).row]
        }
    }
 

    }
}
