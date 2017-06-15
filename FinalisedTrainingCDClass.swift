//
//  FinalisedTraining+CoreDataClass.swift
//  FitHelper
//
//  Created by артем on 09.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData


public class FinalisedTraining: NSManagedObject {
    class var Entity: NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "FinalisedTraining", in: CoreDataHelper.instance.context)!
    }
    convenience init(
        date: NSDate = NSDate() ,
        name: String = "",
        time: Int16 = 0,
        finalisedExercises:NSSet? = nil) {
        self.init(entity: FinalisedTraining.Entity, insertInto: CoreDataHelper.instance.context)
        self.date = date
        self.name = name
        self.time = time
        self.finalisedExercises = finalisedExercises
    }
    
    class func allFinalisedTrainings() ->[FinalisedTraining] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"FinalisedTraining")
        var result:[FinalisedTraining]? = []
        do {
            //var requestRes = try CoreDataHelper.instance.context.execute(request)
            result = try CoreDataHelper.instance.context.fetch(request) as? [FinalisedTraining]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    //TO DO
    //    @NSManaged public var desiredDay: String?
    class func getCurrentTraining(inputTraining:FinalisedTraining) ->[FinalisedTraining]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"FinalisedTraining")
        let namePredicate = NSPredicate(format: "name = %@", inputTraining.name!)
        let datePredicate = NSPredicate(format: "date = %@", inputTraining.date!)
        request.predicate = NSCompoundPredicate(type: .and, subpredicates: [namePredicate,datePredicate])
        var result:[FinalisedTraining]? = []
        do {
            result = try CoreDataHelper.instance.context.fetch(request) as? [FinalisedTraining]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    
    class func allFinalisedTrainingsWithEqualsName(inputName:String) ->[FinalisedTraining] {
        let namePredicate:NSPredicate = NSPredicate(format: "name = %@", inputName)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"FinalisedTraining")
        request.predicate = namePredicate
        var result:[FinalisedTraining]? = []
        do {
            //var requestRes = try CoreDataHelper.instance.context.execute(request)
            result = try CoreDataHelper.instance.context.fetch(request) as? [FinalisedTraining]
        } catch let error{
            print("Error ocorupped \(error.localizedDescription)")
        }
        return result!
    }
    
}
