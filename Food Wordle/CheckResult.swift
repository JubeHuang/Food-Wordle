//
//  CheckResult.swift
//  Food Wordle
//
//  Created by Jube on 2022/10/23.
//

import Foundation
import UIKit

enum CheckResult {
    case correct
    case wrongPlace
    case wrong
    case normal
    
    var color: UIColor {
        switch self {
        case .correct :
            return UIColor(red: 96/255, green: 138/255, blue: 84/255, alpha: 1)
        case .wrongPlace :
            return UIColor(red: 177/255, green: 160/255, blue: 76/255, alpha: 1)
        case .wrong :
            return UIColor(red: 58/255, green: 58/255, blue: 60/255, alpha: 1)
            case .normal :
                return UIColor(red: 107/255, green: 119/255, blue: 141/255, alpha: 1)
        }
    }
    
    var emoji:String {
        switch self {
        case .correct :
            return "🟩"
        case .wrongPlace :
            return "🟨"
        case .wrong :
            return "⬛️"
        case .normal:
            return ""
        }
    }
}
