//
//  ExerciseCDPR.swift
//  FitHelper
//
//  Created by артем on 03.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var exerciseName: String?
    @NSManaged public var specification: String?
    @NSManaged public var weight: Int16
    @NSManaged public var interval: Int16
    @NSManaged public var muscleGroup: String?
    @NSManaged public var repeateNumber: Int16
    @NSManaged public var training: Training?
    @NSManaged public var series: Int16

}
