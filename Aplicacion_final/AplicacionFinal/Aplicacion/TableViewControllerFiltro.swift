//
//  TableViewControllerFiltro.swift
//  Aplicacion
//
//  Created by dam on 16/2/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    

    
    //MARK: Properties

    
    
    //MARK: Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     
     return 1
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
     return actividades.count
     }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            fatalError("He tenido que crear una celda")
        }

        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.actividades.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seleccionaste el indice: ", indexPath.row+1)
    }
    
}

