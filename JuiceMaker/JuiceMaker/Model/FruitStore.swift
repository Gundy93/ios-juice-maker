//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

class FruitStore {
    private(set) var inventory: Dictionary<Fruit, Int>
    
    init(inventory: Dictionary<Fruit, Int>) {
        self.inventory = inventory
    }
    
    init(initialStock: Int) {
        inventory = [:]
        for fruit in Fruit.allCases {
            inventory[fruit] = initialStock
        }
    }
    
    func increaseStock(of fruit: Fruit, by amount: Int) throws {
        guard amount > 0 else {
            throw FruitStoreError.invalidAmount
        }
        guard inventory[fruit] != nil else {
            throw FruitStoreError.notInFruitList
        }
        changeStock(of: fruit, by: amount)
    }
    
    func decreaseStock(of fruit: Fruit, by amount: Int) throws {
        guard amount > 0 else {
            throw FruitStoreError.invalidAmount
        }
        guard let currentStock = inventory[fruit] else {
            throw FruitStoreError.notInFruitList
        }
        guard currentStock >= amount else {
            throw FruitStoreError.outOfStock
        }
        changeStock(of: fruit, by: -amount)
    }
    
    func changeStock(of fruit: Fruit, by amount: Int) {
        if let currentStock = inventory[fruit] {
            inventory[fruit] = currentStock + amount
        }
    }
    
    func checkStockOfFruits(in recipe: [Juice.Ingredient]) throws {
        for ingredient in recipe {
            guard let currentStock = inventory[ingredient.fruit] else {
                throw FruitStoreError.notInFruitList
            }
            guard currentStock >= ingredient.amount else {
                throw FruitStoreError.outOfStock
            }
        }
    }
    
}
