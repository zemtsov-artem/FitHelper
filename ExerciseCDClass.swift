//
//  ExerciseCDClass.swift
//  FitHelper
//
//  Created by артем on 03.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData

public class Exercise: NSManagedObject {
    class var Entity: NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "Exercise", in: CoreDataHelper.instance.context)!
    }
    
    convenience init(
        name: String = "",
        specification: String = "",
        weigth: Int16 = 0,
        interval: Int16 = 0,
        muscleGroup: String = "",
        repeateNumber: Int16 = 0,
        series:Int16 = 0,
        training: Training? = nil)
        {
            self.init(entity: Exercise.Entity, insertInto: CoreDataHelper.instance.context)
            self.exerciseName = name
            self.specification = specification
            self.weigth = weigth
            self.interval = interval
            self.repeateNumber = repeateNumber
            self.training = training
            self.muscleGroup = muscleGroup
            self.series = series
        }
    
    
    class func allExercises() ->[Exercise] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Exercise")
        var result:[Exercise]? = []
        do {
            result = try CoreDataHelper.instance.context.fetch(request) as? [Exercise]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }

}
func showExercise(exercise:Exercise)->Void{
    print (exercise.exerciseName ?? "none name")
    print (exercise.specification ?? "none specification")
    print (exercise.weigth)
    print (exercise.interval)
    print (exercise.muscleGroup ?? "none muscle group")
    print (exercise.repeateNumber)
    print (exercise.series)
    print (exercise.training ?? "none training")
}
