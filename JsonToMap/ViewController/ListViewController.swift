//
//  ListViewController.swift
//  JsonToMap
//
//  Created by André Niet on 26.10.17.
//  Copyright © 2017 André Niet. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = PlacemarksDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        tableView.sectionFooterHeight = 0
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        dataSource.refreshData(for: tableView)
    }

}

