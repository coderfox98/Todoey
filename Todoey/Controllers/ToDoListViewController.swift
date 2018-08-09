//
//  ViewController.swift
//  Todoey
//
//  Created by Rish on 04/08/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Cell]()
    
   
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Cell()
        newItem.item = "Hello"
        newItem.done = false
        itemArray.append(newItem)
      
        if let items = defaults.array(forKey: "ToDoListArray") as? [Cell] {
            itemArray = items
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let myItem = itemArray[indexPath.row]
        cell.textLabel?.text = myItem.item
        
        //Ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = myItem.done ? .checkmark  : .none
//        if myItem.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = itemArray[indexPath.row]
        print(indexPath.row)
        print(selectedItem)
        
        itemArray[indexPath.row].done.toggle()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item ToDo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button
            let newItem = Cell()
            newItem.item = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            print(textField.text)
           
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

