//
//  ChartViewController.swift
//  Wallet
//
//  Created by ITA student on 9/24/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit
import PieCharts

class ChartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PieChartDelegate{

    @IBOutlet weak var chartView: PieChart!
    
    
    @IBOutlet weak var tableReport: UITableView!
    
    let model = DataStore.sharedInstnce
    
    var allTransactions = [Transaction]()
    var allCategories = [CategoriesItem]()
    
    var storeForExpensesByCategory = [expensesByCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableReport.delegate = self
        self.tableReport.dataSource = self
        self.allTransactions = self.model.loadData()
        self.allCategories = self.model.loadCategoriesData()
        self.tableReport.reloadData()
        storeForExpensesByCategory = model.calculateCategory(transaction: allTransactions, category: allCategories)
        self.navigationItem.title = "Report"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem(title: "Chart", style: .Plain, target: self, action: Selector("editTableView"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storeForExpensesByCategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForReport", for: indexPath)
        cell.textLabel?.text = storeForExpensesByCategory[indexPath.row].categoryName
        cell.detailTextLabel?.text = String(storeForExpensesByCategory[indexPath.row].expenses)
        
        return cell
    }

    
    func randomColor() -> UIColor{
        let red = CGFloat(arc4random_uniform(256))/255.0
        let green = CGFloat(arc4random_uniform(256))/255.0
        let blue = CGFloat(arc4random_uniform(256))/255.0
        return UIColor(red : red, green : green, blue : blue, alpha: 0.5)
    }
    
     fileprivate var currentColorIndex = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order  important - models have to be set at the end
    }
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    // MARK: - Models
    
    fileprivate func createModels() -> [PieSliceModel] {
        var models = [PieSliceModel]()
        for item in storeForExpensesByCategory{
            models.append(PieSliceModel(value: item.expenses, color: item.color))
        }
        currentColorIndex = models.count
        return models
    }

    // MARK: - Layers
    
    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.lightGray
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }
}


