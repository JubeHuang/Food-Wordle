//
//  Question.swift
//  Food Wordle
//
//  Created by Jube on 2022/10/23.
//

import Foundation

struct Question {
    let words = ["bacon",
                 "bagel",
                 "berry",
                 "bread",
                 "crepe",
                 "curry",
                 "chili",
                 "feast",
                 "flour",
                 "fried",
                 "gravy",
                 "kebab",
                 "lemon",
                 "liver",
                 "apple",
                 "basil",
                 "chips",
                 "cream",
                 "fruit",
                 "grain",
                 "grape",
                 "guava",
                 "honey",
                 "jelly",
                 "mango",
                 "melon",
                 "mints",
                 "olive",
                 "onion",
                 "pasta",
                 "peach",
                 "pecan",
                 "pizza",
                 "roast",
                 "salad",
                 "salsa",
                 "sauce",
                 "steak",
                 "sugar",
                 "sushi",
                 "syrup",
                 "toast",
                 "torte",
                 "wafer",
                 "water",
                 "wheat"
    ]
    
    
    func newQuestion() -> String {
        let randomWord = words.randomElement()!
        return randomWord.uppercased()
    }
    
    func checkAnser() {
        
    }
}
