//
//  PermanentTVC.swift
//  SPMFS
//
//  Created by Os! on 15/04/2019.
//  Copyright © 2019 Os!. All rights reserved.
//

import UIKit

class PermanentTVC: UITableViewController {

    
        var permArray = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Permenant Disease"

            
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return permArray.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Configure the cell...
            
            print(permArray[indexPath.row])
            cell.textLabel?.text = permArray[indexPath.row]
            
            return cell
        }
        
   
    }

