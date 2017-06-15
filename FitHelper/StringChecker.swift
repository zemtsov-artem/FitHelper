//
//  StringChecker.swift
//  FitHelper
//
//  Created by артем on 09.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import Foundation
import UIKit


func getInt16FromString(_ inputValue:String) ->Int16 {
    if let result = Int16 (inputValue.trimmingCharacters(in: .whitespacesAndNewlines)){
        return result
    } else {
        return 0
    }
    
}

//deprecated
func checkIntInTextView(_ inputTextView:UITextView ) ->Bool {
    let resultText = Int16((inputTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    inputTextView.text = String(describing: resultText)
    if resultText == nil {
        inputTextView.backgroundColor = UIColor.red
        //add crash 
        return false
    } else {
        return true
    }
}
