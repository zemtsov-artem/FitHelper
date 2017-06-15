//
//  FinalisedTraining+CoreDataProperties.swift
//  
//
//  Created by артем on 09.06.17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FinalisedTraining {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinalisedTraining> {
        return NSFetchRequest<FinalisedTraining>(entityName: "FinalisedTraining")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var time: Int16
    @NSManaged public var finalisedExercises: NSSet?

}

// MARK: Generated accessors for finalisedExercises
extension FinalisedTraining {

    @objc(addFinalisedExercisesObject:)
    @NSManaged public func addToFinalisedExercises(_ value: FinalisedExercise)

    @objc(removeFinalisedExercisesObject:)
    @NSManaged public func removeFromFinalisedExercises(_ value: FinalisedExercise)

    @objc(addFinalisedExercises:)
    @NSManaged public func addToFinalisedExercises(_ values: NSSet)

    @objc(removeFinalisedExercises:)
    @NSManaged public func removeFromFinalisedExercises(_ values: NSSet)

}
