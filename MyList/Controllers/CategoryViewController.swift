//
//  CategoryViewController.swift
//  MyList
//
//  Created by Don  on 1/31/19.
//  Copyright © 2019 Don . All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var catArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    //Mark: - TableView Datasource Methods
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = catArray[indexPath.row].name
        
        return cell
        
    }
    
     //Mark: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MyListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catArray[indexPath.row]
        }
    }
    
    //Mark: - Data Manipulation Methods
    
    func saveCategories () {
        
        do {
            try context.save()
        }   catch {
            print("Error Saving Category \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            catArray = try context.fetch(request)
        } catch {
            print("Error loading catArray \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "Add category", style: .default) { (action) in
            // What will happen once the user clicks the add Item button on our UIA;lert
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.catArray.append(newCategory)
            self.saveCategories()
    }
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Create new category"
            
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
}

}



