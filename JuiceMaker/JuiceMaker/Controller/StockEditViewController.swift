//
//  StockEditViewController.swift
//  JuiceMaker
//
//  Created by Gundy, 준호
//

import UIKit

class StockEditViewController: UIViewController {
    weak var delegate: FruitStoreDelegate?
    
    @IBOutlet private var fruitStockLabels: [UILabel]!
    @IBOutlet private var fruitStockSteppers: [UIStepper]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFruitStock()
    }
    
    @IBAction private func touchUpDismissButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction private func touchUpStepper(_ sender: UIStepper) {
        guard let fruit = fruit(of: sender) else {
            return
        }
        if let changedStock = changeStock(of: fruit, by: sender) {
            let label: UILabel = fruitStockLabels[fruit.rawValue]
            label.text = "\(changedStock)"
        }
    }
    
    func fruit(of stepper: UIStepper) -> Fruit? {
        if let fruitIndex = fruitStockSteppers.firstIndex(of: stepper) {
            return Fruit(rawValue: fruitIndex)
        }
        return nil
    }
    
    private func changeStock(of fruit: Fruit, by stockStepper: UIStepper) -> Int? {
        guard let currentStock = try? delegate?.currentStock(of: fruit) else {
            return nil
        }
        let stockStepperValue: Int = Int(stockStepper.value)
        let stockAmountToChange: Int = stockStepperValue - currentStock
        delegate?.changeStock(of: fruit, by: stockAmountToChange)
        return currentStock + stockAmountToChange
    }
    
    private func updateFruitStock() {
        for fruit in Fruit.allCases {
            let fruitStock: Int? = try? delegate?.currentStock(of: fruit)
            updateFruitStockLabel(of: fruit, to: fruitStock)
            updateFruitStockStepper(of: fruit, to: fruitStock)
        }
    }
    
    private func updateFruitStockLabel(of fruit: Fruit, to fruitStock: Int?) {
        let label = fruitStockLabels[fruit.rawValue]
        if let stock = fruitStock {
            label.text = "\(stock)"
        } else {
            label.text = FruitStoreError.notExist
        }
    }
    
    private func updateFruitStockStepper(of fruit: Fruit, to fruitStock: Int?) {
        let stepper = fruitStockSteppers[fruit.rawValue]
        if let stock = fruitStock {
            stepper.value = Double(stock)
        } else {
            stepper.isEnabled = false
        }
    }
}
