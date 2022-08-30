//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

class FruitStore {
    var inventory: Dictionary<Fruit, Int>
    
    init(initialStock: Int) {
        self.inventory = [:]
        for fruit in Fruit.allCases {
            self.inventory[fruit] = initialStock
        }
    }
    
    func add(amount: Int, of fruit: Fruit) {
        guard amount > 0, let currentStock = self.inventory[fruit] else {
            return
        }
        self.inventory[fruit] = currentStock + amount
    }
    
    func subtract(amount: Int, of fruit: Fruit) {
        guard amount > 0, let currentStock = self.inventory[fruit], currentStock >= amount else {
            return
        }
        self.inventory[fruit] = currentStock - amount
    }
}
