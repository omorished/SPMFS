//
//  NoteTVC.swift
//  SPMFS
//
//  Created by Os! on 15/04/2019.
//  Copyright © 2019 Os!. All rights reserved.
//

import UIKit

class NoteTVC: UITableViewController {

    
    var noteArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Note"

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        print(noteArray[indexPath.row])
        cell.textLabel?.text = noteArray[indexPath.row]
        
        return cell
    }
    
    
}
