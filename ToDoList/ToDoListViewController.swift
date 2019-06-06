//
//  ViewController.swift
//  ToDoList
//
//  Created by Silvije Rajda on 6/2/19.
//  Copyright © 2019 Silvije Rajda. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggs", "Listen Music"]
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let items  = defaults.array(forKey: "ToDoListArray") as? [String]
       {
        itemArray = items
        }
        
      
    }
    // TableView Datatsource methods
    
  override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    
 override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for :indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
   
    return cell

    }
    
    // TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     //   print(itemArray[indexPath.row])
 
        
        if   tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
                  tableView.cellForRow(at: indexPath)?.accessoryType = .none
          
        } else {
                   tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
         
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Add new items section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            //once the user clicks add buton on UIAlert
            // print(textField.text)
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
         //   print("Success!!!")
            
    }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
         
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
  }
}




