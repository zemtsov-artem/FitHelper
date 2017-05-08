//
//  DefaultsExercise.swift
//  FitHelper
//
//  Created by артем on 04.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
func setDefaultsExercises() -> Void {
    _ = Exercise( name: "Сгибания шеи на скамье",
                  specification:"Простые сгибания лежа на скамье",
                  weigth: 0,
                  interval: 40,
                  muscleGroup: "Шея",
                  repeateNumber: 30,
                  series:5
    )
    _ = Exercise( name: "Пуловер лежа с гантелей",
                  specification:"Хорошее упражнение на грудные мышцы",
                  weigth: 0,
                  interval: 60,
                  muscleGroup: "Грудь",
                  repeateNumber: 15,
                  series:4
    )
    //save changes
    CoreDataHelper.instance.save()
}
