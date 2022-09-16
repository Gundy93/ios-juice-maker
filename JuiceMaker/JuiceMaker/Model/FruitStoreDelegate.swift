//
//  FruitStoreDelegate.swift
//  JuiceMaker
//
//  Created by Gundy, 준호
//

protocol FruitStoreDelegate: AnyObject {
    func currentStock(of fruit: Fruit) throws -> Int
    func changeStock(of fruit: Fruit, by amount: Int)
}
