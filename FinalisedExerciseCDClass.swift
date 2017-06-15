//
//  FinalisedExercise+CoreDataClass.swift
//  FitHelper
//
//  Created by артем on 09.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData

public class FinalisedExercise: NSManagedObject {
    class var Entity: NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "FinalisedExercise", in: CoreDataHelper.instance.context)!
    }
    convenience init(
        name: String = "",
        time: Int16 = 0,
        seriesWeightValues: [Int16] = [],
        seriesRepeateValues: [Int16] = [],
        finalisedTraining:FinalisedTraining? = nil) {
        self.init(entity: FinalisedExercise.Entity, insertInto: CoreDataHelper.instance.context)
        self.name = name
        self.time = time
        self.seriesWeightValues = seriesWeightValues
        self.seriesRepeateValues = seriesRepeateValues
        self.finalisedTraining = finalisedTraining
    }
    
    class func allFinalisedTrainings() ->[FinalisedExercise] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"FinalisedExercise")
        var result:[FinalisedExercise]? = []
        do {
            //var requestRes = try CoreDataHelper.instance.context.execute(request)
            result = try CoreDataHelper.instance.context.fetch(request) as? [FinalisedExercise]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    
    class func allFinalisedExerciseWithEqualsName(inputName:String) ->[FinalisedExercise] {
        let namePredicate:NSPredicate = NSPredicate(format: "name = %@", inputName)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"FinalisedExercise")
        request.predicate = namePredicate
        var result:[FinalisedExercise]? = []
        do {
            //var requestRes = try CoreDataHelper.instance.context.execute(request)
            result = try CoreDataHelper.instance.context.fetch(request) as? [FinalisedExercise]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    
    
    
}
