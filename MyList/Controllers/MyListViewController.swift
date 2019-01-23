//
//  ViewController.swift
//  MyList
//
//  Created by Don  on 1/18/19.
//  Copyright © 2019 Don . All rights reserved.
//

import UIKit

class MyListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem.title = "Buy Eggos"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem.title = "Destory Demogorgon"
        itemArray.append(newItem3)

        
        if let items = defaults.array(forKey: "MyListArray") as? [Item] {
                itemArray = items
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    //MARK - Tableview Datasource Methods

    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
}
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        // Ternary Operator Line Above Replaces Following If Statement
/*        if item.done == true {
            cell.accessoryType = .checkmark
        }   else {
            cell.accessoryType = .none
        }
*/
        return cell
        
    }
    
    

    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        /*if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        */
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New MyList Item", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "Add item", style: .default) { (action) in
            // What will happen once the user clicks the add Item button on our UIA;lert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "MyListArray")
            
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

