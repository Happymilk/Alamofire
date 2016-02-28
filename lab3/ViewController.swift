//
//  ViewController.swift
//  lab3
//
//  Created by Admin on 28.02.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var valueText: UITextField!
    @IBOutlet weak var table: UITableView!
    
    var value: Double = 0;
    var values:[MyValue] = [MyValue(Currency:"", Value:"")];
    
    let url = "https://www.nbrb.by/Services/XmlExRates.aspx"
    
    @IBAction func hideKey(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func Count(sender: AnyObject) {
        if let val = Double(valueText.text!) {
            if val >= 0 {
                self.value = val
            }
        }
        self.table.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell")
        cell?.textLabel?.text = values[indexPath.row].cur
        cell?.detailTextLabel?.text = String(format:"%.3f", self.value/self.values[indexPath.row].val)
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.values.removeAll()
        Alamofire.request(.GET, url, parameters: nil).response {
            (request, response, data, error) in
                if data != nil {
                    let xml = SWXMLHash.parse(data!)
                    for i in xml["DailyExRates"]["Currency"] {
                        let rate = i["Rate"].element!.text!
                        let charCode = i["CharCode"].element!.text!
                        let currency = MyValue(Currency: charCode, Value: rate)
                        self.values.append(currency)
                    }
                }
        }
        self.table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

