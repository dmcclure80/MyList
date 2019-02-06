//
//  CategoryViewController.swift
//  MyList
//
//  Created by Don  on 1/31/19.
//  Copyright © 2019 Don . All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var catArray: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        
        
    }

    //Mark: - TableView Datasource Methods
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray?.count ?? 1
    }
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = catArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
        
    }
    
     //Mark: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MyListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catArray?[indexPath.row]
        }
    }
    
    //Mark: - Data Manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        }   catch {
            print("Error Saving Category \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        catArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //Mark: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
    
        if let categoryForDeletion = self.catArray?[indexPath.row] {
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }  catch{
                print("Error deleting category, \(error)")
         }
         
         }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "Add category", style: .default) { (action) in
            // What will happen once the user clicks the add Item button on our UIA;lert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
    }
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Create new category"
            
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
}
    
}



