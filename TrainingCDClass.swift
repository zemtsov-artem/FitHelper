//
//  TrainingCDClass.swift
//  FitHelper
//
//  Created by артем on 03.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData


public class Training: NSManagedObject {
    class var Entity: NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "Training", in: CoreDataHelper.instance.context)!
    }
    convenience init(
        desiredDay: String = "",
        specification: String = "",
        trainingName: String = "",
        trainingType: String = "",
        exercises:NSOrderedSet? = nil) {
            self.init(entity: Training.Entity, insertInto: CoreDataHelper.instance.context)
            self.desiredDay = desiredDay
            self.specification = specification
            self.trainingName = trainingName
            self.trainingType = trainingType
            self.exercise = exercises
    }
        
    class func allTrainings() ->[Training] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Training")
        var result:[Training]? = []
        do {
            //var requestRes = try CoreDataHelper.instance.context.execute(request)
            result = try CoreDataHelper.instance.context.fetch(request) as? [Training]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    //TO DO
//    @NSManaged public var desiredDay: String?
    class func getCurrentTraining(inputTraining:Training) ->[Training]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Training")
        let namePredicate = NSPredicate(format: "trainingName = %@", inputTraining.trainingName!)
        let specificationPredicate = NSPredicate(format: "specification = %@", inputTraining.specification!)
        let desiredDayPredicate = NSPredicate(format: "desiredDay = %@", inputTraining.desiredDay!)
        let trainingTypePredicate = NSPredicate(format: "trainingType = %@", inputTraining.trainingType!)
        request.predicate = NSCompoundPredicate(type: .and, subpredicates: [namePredicate,specificationPredicate,desiredDayPredicate,trainingTypePredicate])
        var result:[Training]? = []
        do {
            result = try CoreDataHelper.instance.context.fetch(request) as? [Training]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    
}
