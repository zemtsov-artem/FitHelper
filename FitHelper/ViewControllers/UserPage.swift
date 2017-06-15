//
//  UserPage.swift
//  FitHelper
//
//  Created by артем on 28.04.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class UserPage: UIViewController {

    private var today : NSDate!
    private var gregorianCalendar:NSCalendar!
    private var weekdayComponent : NSDateComponents!
    private var currentDay:Int = 0
    private let cornerRadValue:CGFloat = 12.0
   
    @IBOutlet weak var trainingNameForToday: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var buttonState: UIButton!
    
    @IBOutlet weak var summaryWeight: UILabel!
    @IBOutlet weak var finalisedExercisesNum: UILabel!
    @IBOutlet weak var finilisedTrainingsNum: UILabel!
    @IBOutlet weak var allTrainingsTime: UILabel!
    
    @IBOutlet weak var firstLabelColor: UILabel!
    @IBOutlet weak var secondLabelColor: UILabel!
    @IBOutlet weak var thirdLabelColor: UILabel!
    @IBOutlet weak var fourthLabelColor: UILabel!
    
    
    private let secondsInMin:Int = 60
    private let secondsInhour:Int = 3600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabelColor.layer.cornerRadius = cornerRadValue
        firstLabelColor.layer.masksToBounds = true
        
        secondLabelColor.layer.cornerRadius = cornerRadValue
        secondLabelColor.layer.masksToBounds = true
        
        thirdLabelColor.layer.cornerRadius = cornerRadValue
        thirdLabelColor.layer.masksToBounds = true
        
        fourthLabelColor.layer.cornerRadius = cornerRadValue
        fourthLabelColor.layer.masksToBounds = true
        
        updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func updateData(){
        let finilisedTrainings = FinalisedTraining.allFinalisedTrainings()
        var allTime:Int = 0
        var allExercisesNum:Int = 0
        var allTrainingsNum:Int = 0
        var allWeight:Double = 0
        
        if finilisedTrainings.count > 0 {
            for training in finilisedTrainings{
                allTime += Int(training.time)
                allTrainingsNum += 1
                if let exercisesArr = training.finalisedExercises{
                    for exercise in exercisesArr{
                        allExercisesNum += 1
                        if let exerciseEx = exercise as? FinalisedExercise{
                            for weight in exerciseEx.seriesWeightValues!{
                                allWeight += Double(weight)
                            }
                        }
                        
                        
                }
            }
            }
        }
        summaryWeight.text = String(allWeight/1000) + " тонн"
        finalisedExercisesNum.text = String(allExercisesNum)
        finilisedTrainingsNum.text = String(allTrainingsNum)
        let newFormatAllTime = formatterForDate(allTime)
        allTrainingsTime.text = String(newFormatAllTime)
        
        today = NSDate()
        gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        weekdayComponent = gregorianCalendar.components(.weekday, from: today as Date) as NSDateComponents
        currentDay = weekdayComponent.weekday - 1 //адаптируем трофейный календарь под отечественный
        self.navigationItem.title = "Сегодня " + fromNumToNameOfTheDay(num: currentDay)
        //Update training name and button
        if let todayTraining = checkTrainingsForToday(nameOfTheDay: fromNumToNameOfTheDay(num: currentDay)){
            trainingNameForToday.text = todayTraining.trainingName
            buttonState.isHidden = false
        } else {
            trainingNameForToday.text = "Нет запланированных тренировок"
            buttonState.isHidden = true
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? listOfExercisesInActivityTraining {
            if segue.identifier == "goToTheTrainingFromMain"{
                destination.currentTraining = checkTrainingsForToday(nameOfTheDay: fromNumToNameOfTheDay(num: currentDay))
                navigationController?.navigationBar.topItem?.title = " "
        }
    }

}
    private func formatterForDate(_ inputSeconds:Int) ->String{
        let hour = inputSeconds/secondsInhour
        let minutes = (inputSeconds%secondsInhour )/secondsInMin
        let seconds = inputSeconds%secondsInMin
        let result = (String(hour) + "ч:" + String(minutes) + "м:" + String(seconds)+"c")
        return result
    }
}
