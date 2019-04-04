//
//  FirstViewController.swift
//  Smart-Task-Lights
//
//  Created by Kimberly Zhu on 3/23/19.
//  Copyright © 2019 UCB-Team-Tech. All rights reserved.
//

import UIKit


class DevicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var energyConsumed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("\(global.energyConsumed) kwh")
        energyConsumed.text = "\(global.energyConsumed) kwh"
        
        // set a background color so we can easily see the table
        //self.view.backgroundColor = UIColor.blue
        
        // add the table view to self.view
        self.view.addSubview(tableView)
        
        // table constraints
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 370.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        
        //for border around the table
        //tableView.layer.borderWidth = 3
        //tableView.layer.borderColor = UIColor.black.cgColor
        
        // set delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        // register a defalut cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    // Note: because this is NOT a subclassed UITableViewController,
    // DataSource and Delegate functions are NOT overridden
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.text = "Light: \(indexPath.row) \n Last seen: \(global.lightInfo[indexPath.row][0]) minutes ago \n Power consumed: \(global.lightInfo[indexPath.row][1]) kWh"
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // etc
    }

}

