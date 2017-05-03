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
    convenience init(){
        self.init(entity: Training.Entity, insertInto: CoreDataHelper.instance.context)
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
}
