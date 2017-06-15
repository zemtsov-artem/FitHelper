//
//  FinalisedExercise+CoreDataProperties.swift
//  FitHelper
//
//  Created by артем on 09.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import CoreData


extension FinalisedExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinalisedExercise> {
        return NSFetchRequest<FinalisedExercise>(entityName: "FinalisedExercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var seriesWeightValues: [Int16]?
    @NSManaged public var seriesRepeateValues: [Int16]?
    @NSManaged public var time: Int16
    @NSManaged public var finalisedTraining: FinalisedTraining?
    
    
    

}

