//
//  FinalisedExercise+CoreDataProperties.swift
//  
//
//  Created by артем on 09.06.17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FinalisedExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinalisedExercise> {
        return NSFetchRequest<FinalisedExercise>(entityName: "FinalisedExercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var seriesValues: NSObject?
    @NSManaged public var time: Int16
    @NSManaged public var finalisedTraining: FinalisedTraining?

}
