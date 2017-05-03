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
    convenience init(){
        self.init(entity: Exercise.Entity, insertInto: CoreDataHelper.instance.context)
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
