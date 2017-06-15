//
//  FromNumToNameOfTheDay.swift
//  FitHelper
//
//  Created by артем on 02.06.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import UIKit

func fromNumToNameOfTheDay(num:Int)->String{
    switch num {
    case 1:
        return "Понедельник"
    case 2:
        return "Вторник"
    case 3:
        return "Среда"
    case 4:
        return "Четверг"
    case 5:
        return "Пятница"
    case 6:
        return "Суббота"
    case 0:
        return "Воскресенье"
        
    default:
        return "default day num"
    }
}
