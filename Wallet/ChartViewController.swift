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
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var tableReport: UITableView!
    
    var storeForExpensesByCategory = [ExpensesByCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableReport.delegate = self
        self.tableReport.dataSource = self
        self.tableReport.reloadData()
        self.navigationItem.title = "Report"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storeForExpensesByCategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForReport", for: indexPath) as? ReportTableViewCell
        cell?.categoryTitle.text = storeForExpensesByCategory[indexPath.row].categoryName
        cell?.categoryValue.text = String(format: "%.2f", storeForExpensesByCategory[indexPath.row].expenses) + " ₴"
        cell?.categoryColor.backgroundColor = storeForExpensesByCategory[indexPath.row].color
        return cell!
    }
    
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
            models.append(PieSliceModel(value: Double(item.expenses), color: item.color))
        }
        // currentColorIndex = models.count
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


