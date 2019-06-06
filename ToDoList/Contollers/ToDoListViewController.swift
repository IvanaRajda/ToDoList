//
//  ViewController.swift
//  ToDoList
//
//  Created by Silvije Rajda on 6/2/19.
//  Copyright © 2019 Silvije Rajda. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadItems()
    }
    // TableView Datatsource methods
    
  override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    
 override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for :indexPath)
    let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
    
    cell.accessoryType = item.done ? .checkmark : .none
    
//    if item.done == true{
//        cell.accessoryType = .checkmark
//    } else {
//        cell.accessoryType = .none
//    }
   // cell.accessoryType = item.done == true ?  .checkmark : .none
   
    return cell
    }
    
    // TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   print(itemArray[indexPath.row])
 
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Add new items section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            //once the user clicks add buton on UIAlert
            // print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
         
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
  }
    
    // Model Manipulation Methods
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
        //   print("Success!!!")
        
        
    }
   func loadItems(){
   if let data = try? Data(contentsOf: dataFilePath!){
        let decoder = PropertyListDecoder()
    do{
        itemArray = try decoder.decode([Item].self, from: data)
    }catch{
        print("Error, \(error)")
      }
    }
  }
}


