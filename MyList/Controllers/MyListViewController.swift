//
//  ViewController.swift
//  MyList
//
//  Created by Don  on 1/18/19.
//  Copyright © 2019 Don . All rights reserved.
//

import UIKit
import RealmSwift

class MyListViewController: UITableViewController {
    
    var itemList: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
    }

    //MARK - Tableview Datasource Methods

    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 1
}
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListItemCell", for: indexPath)
        
        if let item = itemList?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        }  else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
        
    }
    
    

    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
/*
        itemList[indexPath.row].done = !itemList[indexPath.row].done
        
        saveItems()
  */
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New MyList Item", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "Add item", style: .default) { (action) in
            // What will happen once the user clicks the add Item button on our UIA;lert
            
            
          if let currentCategory = self.selectedCategory {
            do {
                try self.realm.write {
                let newItem = Item()
                newItem.title = textField.text!
                currentCategory.item.append(newItem)
                }
            }  catch {
                print("Error saving new items, \(error)")
            }
            
        }
            self.tableView.reloadData()
    }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    
    /*func saveItems () {
        
        do {
            try context.save()
        }   catch {
            print("Error Saving Context |(error)")
        }
        
        
        self.tableView.reloadData()
    }*/
    
    func loadItems() {
        
        itemList = selectedCategory?.item.sorted(byKeyPath: "title", ascending: true)
        
        
        tableView.reloadData()
    }
    
    
}   //MARK: - Search Bar methods

/*
extension MyListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        //loadItems()
    }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()
                
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
              
            }
        }

}*/
