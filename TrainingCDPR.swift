//
//  TrainingCDPR.swift
//  FitHelper
//
//  Created by артем on 03.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var desiredDay: String?
    @NSManaged public var specification: String?
    @NSManaged public var trainingName: String?
    @NSManaged public var trainingType: String?
    @NSManaged public var exercise: NSOrderedSet?

}

// MARK: Generated accessors for exercise
extension Training {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}
