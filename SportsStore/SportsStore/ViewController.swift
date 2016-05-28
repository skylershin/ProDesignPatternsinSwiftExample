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
    var productStore = ProductDataStore()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayStockTotal()
        
        productStore.callback = {(p:Product) in
            for cell in self.tableView.visibleCells {
                if let pcell = cell as? ProductTabelCell {
                    if pcell.product!.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel)
                        pcell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTabelCell
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        
        return cell
    }
    
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0), combine: {
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

