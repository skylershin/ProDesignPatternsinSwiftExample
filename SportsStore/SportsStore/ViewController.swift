//
//  ViewController.swift
//  SportsStore
//
//  Created by MunkyuShin on 4/9/16.
//  Copyright © 2016 munkyu. All rights reserved.
//

import UIKit

class ProductTabelCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    var product: Product?
    
    
}

var handler = { (p:Product) in
    print("Change: \(p.name) \(p.stockLevel) items in stock ")
}

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //let logger = Logger<Product>(callback: handler)
    
    var products = [
        Product(name:"Kayak", description: "A boat for one person", category: "Watersports", price:275.0, stockLevel:10),
        Product(name:"Lifejacket", description: "Protective and fashinable", category: "Watersports", price:48.95, stockLevel:14),
        Product(name:"Soccer Ball", description: "FIFA-approved size and weight", category: "Soccer", price:19-5, stockLevel:32),
        Product(name:"Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price:34-95, stockLevel:1),
        Product(name:"Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price:79500.0, stockLevel:4),
        Product(name:"Thinking Cap", description: "Improve your brain efficiency by 75%", category: "Chess", price:16.0, stockLevel:8),
        Product(name:"Unsteady Chair", description: "Secretly give your oppenent a disadvantage", category: "Chess", price:29.95, stockLevel:3),
        Product(name:"Human Chess Board", description: "A fun game for the family", category: "Chess", price:75.0, stockLevel:2),
        Product(name:"Bling-Bling King", description: "Gold-plated, diamond-studded King", category: "Chess", price:1200.0, stockLevel:4)
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayStockTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTabelCell
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        
        return cell
    }
    
    func displayStockTotal() {
        let finalTotals:(Int, Double) = products.reduce((0, 0.0), combine: {
            (totals, product) -> (Int, Double) in
                return (
                    totals.0 + product.stockLevel,
                    totals.1 + product.stockValue
                )
        })
        
        totalStockLabel.text = "\(finalTotals.0) Products in Stock"
        + "Total Value: \(Utils.currencyStringFromNumber(finalTotals.1))"
    }
    
    @IBAction func stockLevelDidChanged(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while true {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTabelCell {
                    if let product = cell.product {
                        
                        if  let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!) {
                                product.stockLevel = newValue
                            }
                           
                        }
                        
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }

}

