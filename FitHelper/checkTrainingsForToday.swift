//
//  checkTrainingsForToday.swift
//  FitHelper
//
//  Created by артем on 02.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation

func checkTrainingsForToday(nameOfTheDay:String)->Training?{
    let trainings:[Training] = Training.allTrainings()
    for item in trainings{
        if item.desiredDay == nameOfTheDay {
            return item
        }
    }
    return nil
}


