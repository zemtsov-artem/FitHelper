//
//  imagePickerForExercise.swift
//  FitHelper
//
//  Created by артем on 02.06.17.
//  Copyright © 2017 артем. All rights reserved.
//
import UIKit
import Foundation


func getImageByMuscleGroupName(muscleGroupname:String)->UIImage{
    switch muscleGroupname {
    case "Трапеции":
        return #imageLiteral(resourceName: "trapezius")
    case "Плечи":
        return #imageLiteral(resourceName: "shoulder")
    case "Бицепс":
        return #imageLiteral(resourceName: "biceps")
    case "Грудь":
        return #imageLiteral(resourceName: "pectoral")
    case "Предплечья":
        return #imageLiteral(resourceName: "prearm")
    case "Пресс":
        return #imageLiteral(resourceName: "abdomen")

    case "Трицепс":
        return #imageLiteral(resourceName: "triceps")
    case "Широчайшие":
        return #imageLiteral(resourceName: "dorsal")
    case "Средние спинные":
        return #imageLiteral(resourceName: "backMiddle")
    case "Нижние спинные":
        return #imageLiteral(resourceName: "backDown")
    case "Квадрицепсы":
        return #imageLiteral(resourceName: "squareBic")
    case "Ягодицы":
        return #imageLiteral(resourceName: "assMucle")
    case "Бедра":
        return #imageLiteral(resourceName: "backLeg")
    case "Икры":
        return #imageLiteral(resourceName: "calf")
    default:
        return #imageLiteral(resourceName: "defExercise")
    }
}
