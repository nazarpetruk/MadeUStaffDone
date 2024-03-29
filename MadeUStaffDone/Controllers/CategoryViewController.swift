//
//  CategoryViewController.swift
//  MadeUStaffDone
//
//  Created by Nazar Petruk on 05/08/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: SwipeViewController {
    //Global variables
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        tableView.rowHeight = 80.0
        
    }
    
    // MARK: - Table view data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let categoryItem = categoryArray[indexPath.row]
        cell.textLabel?.text = categoryItem.name
        return cell
        
    }
    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "getItems", sender: self)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationView = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationView.selectedCategory = categoryArray[indexPath.row]
       }
        
    }
    //MARK: Alert + new category item creation
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {(action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    //MARK: Category DataBase Data manipulations
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("Save category issue \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categoryArray = try context.fetch(request)
        }catch{
            print("Error with reading Data \(error)")
        }
    }
    
    //Deletion from superClass
    override func updateModel(indexPath: IndexPath) {
        context.delete(categoryArray[indexPath.row])
        categoryArray.remove(at: indexPath.row)
        saveCategory()
    }
}


