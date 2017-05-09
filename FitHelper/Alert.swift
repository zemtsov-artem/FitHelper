//
//  Alert.swift
//  FitHelper
//
//  Created by артем on 09.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import AudioToolbox
import UIKit

class invalideInputAlertData{
    var namesArray:[String] = []
    var dataName:String
    init(namesArray:[String],dataName:String){
        self.namesArray = namesArray
        self.dataName = dataName
    }
    func showAlert() ->Void {
        dataName = dataName.lowercased()
        let alert = UIAlertController(title: "Неверные данные", message: "Исправьте поля: \(dataName)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
    }
}
