//
//  AntibioticsTV.swift
//  SPMFS
//
//  Created by Os! on 15/04/2019.
//  Copyright © 2019 Os!. All rights reserved.
//

import UIKit

class AntibioticsTV: UITableViewController {

    var antiArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     self.title = "Antibiotics"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return antiArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        print(antiArray[indexPath.row])
        cell.textLabel?.text = antiArray[indexPath.row]

        return cell
    }
    

  

}
