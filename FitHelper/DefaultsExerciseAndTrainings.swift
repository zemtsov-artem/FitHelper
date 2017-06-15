//
//  DefaultsExercise.swift
//  FitHelper
//
//  Created by артем on 04.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
func setDefaultsExercises() {
    _ = Exercise( name: "Сгибания шеи на скамье",
                  specification:"Простые сгибания лежа на скамье",
                  weight: 0,
                  interval: 90,
                  muscleGroup: "Трапеции",
                  repeateNumber: 30,
                  series:5
    )
    _ = Exercise( name: "Пуловер лежа с гантелей",
                  specification:"Хорошее упражнение на грудные мышцы",
                  weight: 50,
                  interval: 90,
                  muscleGroup: "Грудь",
                  repeateNumber: 15,
                  series:4
    )
    _ = Exercise( name: "Жим штанги лежа",
                  specification:"Хорошее упражнение на грудные мышцы",
                  weight: 70,
                  interval: 90,
                  muscleGroup: "Грудь",
                  repeateNumber: 12,
                  series:4
    )

    _ = Exercise( name: "Жим штанги под углом",
                  specification:"Хорошее упражнение на грудные мышцы",
                  weight: 40,
                  interval: 90,
                  muscleGroup: "Грудь",
                  repeateNumber: 12,
                  series:4
    )

    _ = Exercise( name: "Бицепс машина",
                  specification:"Хорошее упражнение на бицепс",
                  weight: 22,
                  interval: 90,
                  muscleGroup: "Бицепс",
                  repeateNumber: 20,
                  series:4
    )

    _ = Exercise( name: "Молот сидя",
                  specification:"Хорошее упражнение на бицепс",
                  weight: 15,
                  interval: 90,
                  muscleGroup: "Бицепс",
                  repeateNumber: 15,
                  series:4
    )

    _ = Exercise( name: "Жим гантелей лежа",
                  specification:"Хорошее упражнение на грудные мышцы",
                  weight: 27,
                  interval: 90,
                  muscleGroup: "Грудь",
                  repeateNumber: 12,
                  series:4
    )

    _ = Exercise( name: "Сгибания на скамье",
                  specification:"Хорошее упражнение на пресс",
                  weight: 0,
                  interval: 90,
                  muscleGroup: "Пресс",
                  repeateNumber: 30,
                  series:4
    )

    _ = Exercise( name: "Присяд со штангой",
                  specification:"Хорошее базовое упражнение на квадрицепс, ягодицы, бедра",
                  weight: 90,
                  interval: 90,
                  muscleGroup: "Бедра",
                  repeateNumber: 12,
                  series:4
    )

    _ = Exercise( name: "Разгибания ног сидя",
                  specification:"Хорошее упражнение на квадрицепс ",
                  weight: 40,
                  interval: 90,
                  muscleGroup: "Квадрицепсы",
                  repeateNumber: 12,
                  series:4
    )

    _ = Exercise( name: "Жим ногами",
                  specification:"Хорошее базовое упражнение на квадрицепс, ягодицы, бедра",
                  weight: 0,
                  interval: 90,
                  muscleGroup: "Бедра",
                  repeateNumber: 12,
                  series:4
    )

    //save changes
    CoreDataHelper.instance.save()
}


func setDefaultTrainings() {
    let exerciseList = Exercise.allExercises()
    
    var legExercises:[Exercise] = []
    var armExercises:[Exercise] = []
    var backSideExercises:[Exercise] = []
    if exerciseList.count > 0{
        for exerciseIndex in 0..<exerciseList.count{
            switch exerciseList[exerciseIndex].muscleGroup! {
            case "Трапеции":
                armExercises.append(exerciseList[exerciseIndex])
            case "Плечи":
                legExercises.append(exerciseList[exerciseIndex])
            case "Бицепс":
                armExercises.append(exerciseList[exerciseIndex])
            case "Грудь":
                armExercises.append(exerciseList[exerciseIndex])
            case "Предплечья":
                armExercises.append(exerciseList[exerciseIndex])
            case "Пресс":
                armExercises.append(exerciseList[exerciseIndex])
                legExercises.append(exerciseList[exerciseIndex])
                backSideExercises.append(exerciseList[exerciseIndex])
            case "Квадрицепсы":
                legExercises.append(exerciseList[exerciseIndex])
            case "Трицепс":
                armExercises.append(exerciseList[exerciseIndex])
            case "Широчайшие":
                backSideExercises.append(exerciseList[exerciseIndex])
            case "Средние спинные":
                backSideExercises.append(exerciseList[exerciseIndex])
            case "Нижние спинные":
                backSideExercises.append(exerciseList[exerciseIndex])
            case "Ягодицы":
                legExercises.append(exerciseList[exerciseIndex])
            case "Бедра":
                legExercises.append(exerciseList[exerciseIndex])
            case "Икры":
                legExercises.append(exerciseList[exerciseIndex])

            default:
                print ("Something went wrong")
                
            }
        }
        var _ :Training = Training(desiredDay: "Понедельник", specification: "День ног лучше начинать с хорошей разминки и недолгой игры в теннис", trainingName: "День ног",
                                       trainingType: "Силовая", exercises: NSOrderedSet(array: legExercises))
        
        var _ :Training = Training(desiredDay: "Среда", specification: "День груди лучше начинать с хорошей разминки и разогревочного подхода упражнения 'Жим штанги лежа' ", trainingName: "День груди", trainingType: "Силовая", exercises: NSOrderedSet(array: armExercises))
        
        var _ :Training = Training(desiredDay: "Пятница", specification: "Без лишних нагрузок , при обязательной разминке и заминке", trainingName: "День спины", trainingType: "Силовая", exercises: NSOrderedSet(array: backSideExercises))
        CoreDataHelper.instance.save()
    }
}
