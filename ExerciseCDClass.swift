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
        weight: Int16 = 0,
        interval: Int16 = 0,
        muscleGroup: String = "",
        repeateNumber: Int16 = 0,
        series:Int16,
        training: Training? = nil)
        {
            self.init(entity: Exercise.Entity, insertInto: CoreDataHelper.instance.context)
            self.exerciseName = name
            self.specification = specification
            self.weight = weight
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

    class func getCurrentExercise(inputExercise:Exercise) ->[Exercise]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Exercise")
        let namePredicate:NSPredicate = NSPredicate(format: "exerciseName = %@", inputExercise.exerciseName!)
        let weightPredicate:NSPredicate = NSPredicate(format: "weight = %d", inputExercise.weight)
        let specificationPredicate:NSPredicate = NSPredicate(format: "specification = %@", inputExercise.specification!)
        let muscleGroupPredicate:NSPredicate = NSPredicate(format: "muscleGroup = %@", inputExercise.muscleGroup!)
        let repeateNumberPredicate:NSPredicate = NSPredicate(format: "repeateNumber = %d", inputExercise.repeateNumber)
        let seriesPredicate:NSPredicate = NSPredicate(format: "series = %d", inputExercise.series)
        request.predicate = NSCompoundPredicate(type: .and, subpredicates: [namePredicate,muscleGroupPredicate,weightPredicate,specificationPredicate,repeateNumberPredicate,seriesPredicate])
        var result:[Exercise]? = []
        do {
            result = try CoreDataHelper.instance.context.fetch(request) as? [Exercise]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }

}

