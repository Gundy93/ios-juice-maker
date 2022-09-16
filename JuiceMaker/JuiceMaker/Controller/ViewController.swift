//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private var fruitStore = FruitStore(inventory: [.strawberry: 10, .banana:10, .kiwi: 10, .mango: 10])
    private lazy var juiceMaker = JuiceMaker(fruitStore: fruitStore)
    
    @IBOutlet private var juiceOrderButtons: [UIButton]!
    @IBOutlet private var fruitStockLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFruitStockLabel()
        adjustsFontSizeOfButtonsToFitWidth()
    }
    
    @IBAction private func touchUpEditStockButton(_ sender: UIBarButtonItem) {
        presentStockEditView()
    }
    
    @IBAction private func touchUpJuiceOrderButton(_ sender: UIButton) {
        guard let juice = juice(orderedBy: sender) else {
            return
        }
        let result: Result<Juice, FruitStoreError> = juiceMaker.make(juice)
        switch result {
        case .success(let madeJuice):
            updateFruitStockLabel()
            showOkayAlert("\(madeJuice.name) \(AlertText.juiceCompletion)")
        case .failure(let fruitStoreError):
            switch fruitStoreError {
            case .outOfStock:
                showStockEditAlert(fruitStoreError.localizedDescription)
            case .notInInventoryFruitList:
                showAddFruitsAlert(of: juice, fruitStoreError.localizedDescription)
            default:
                showOkayAlert(fruitStoreError.localizedDescription)
            }
        }
    }
    
    private func juice(orderedBy button: UIButton) -> Juice? {
        if let juiceIndex = juiceOrderButtons.firstIndex(of: button) {
            return Juice(rawValue: juiceIndex)
        }
        return nil
    }
    
    private func showOkayAlert(_ message: String) {
        let okAction = UIAlertAction(title: AlertText.okay,
                                     style: .default,
                                     handler: nil)
        showAlert(message, alertActions: okAction)
    }
    
    private func showStockEditAlert(_ message: String) {
        let editAction = UIAlertAction(title: AlertText.yes,
                                       style: .default) { (action) in
            self.presentStockEditView()
        }
        let cancelAction = UIAlertAction(title: AlertText.no,
                                         style: .default)
        showAlert(message, alertActions: editAction, cancelAction)
    }
    
    private func showAddFruitsAlert(of juice: Juice, _ message: String) {
        let addAction = UIAlertAction(title: AlertText.yes,
                                      style: .default) { (action) in
            self.fruitStore.addNewFruitsOf(juice.fruitList)
            self.updateFruitStockLabel()
        }
        let cancelAction = UIAlertAction(title: AlertText.no,
                                         style: .default)
        showAlert(message, alertActions: addAction, cancelAction)
    }
    
    private func showAlert(_ message: String, alertActions: UIAlertAction...) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        for alertAction in alertActions {
            alert.addAction(alertAction)
        }
        present(alert,
                animated: true,
                completion: nil)
    }
    
    private func presentStockEditView() {
        guard let stockEditViewController = self.storyboard?.instantiateViewController(withIdentifier: "StockEditViewController") as? StockEditViewController else {
            return
        }
        stockEditViewController.delegate = self.fruitStore
        let navigationController = UINavigationController(rootViewController: stockEditViewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController,
                     animated: true,
                     completion: nil)
    }
    
    private func updateFruitStockLabel() {
        for (fruitStockLabel, fruit) in zip(fruitStockLabels, Fruit.allCases) {
            if let fruitStock = try? fruitStore.currentStock(of: fruit) {
                fruitStockLabel.text = "\(fruitStock)"
            } else {
                fruitStockLabel.text = FruitStoreError.notExist
            }
        }
    }
    
    private func adjustsFontSizeOfButtonsToFitWidth() {
        for button in juiceOrderButtons {
            button.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
}
