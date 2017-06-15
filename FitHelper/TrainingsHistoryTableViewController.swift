//
//  TrainingsHistoryTableViewController.swift
//  FitHelper
//
//  Created by артем on 13.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit

class TrainingsHistoryTableViewController: UITableViewController {

    
    var finilesedTrainings:[FinalisedTraining]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        finilesedTrainings = FinalisedTraining.allFinalisedTrainings()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finilesedTrainings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trainingHistoryCell", for: indexPath)

        cell.textLabel?.text = finilesedTrainings[indexPath.row].name
        cell.detailTextLabel?.text = getDate(inputNSDate: finilesedTrainings[indexPath.row].date!)

        return cell
    }
    private func getDate(inputNSDate:NSDate) ->String{
        let dayFormatter: DateFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let monthFormatter: DateFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let yearFormatter: DateFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        
        return (dayFormatter.string(from: inputNSDate as Date) + "." +
            monthFormatter.string(from: inputNSDate as Date) + "." +
            yearFormatter.string(from: inputNSDate as Date)
            )
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndexPath:IndexPath = IndexPath(item: indexPath.row, section: 0)
        performSegue(withIdentifier: "toFinalisedTrainingInfo", sender: myIndexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FinalisedTrainingInfo{
            if segue.identifier == "toFinalisedTrainingInfo" {
                let pathIndex = sender!
                destination.currentFinalisedTraining = finilesedTrainings[(pathIndex as AnyObject).row]
            }
        }
    }
 

}
