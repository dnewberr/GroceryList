//
//  GroceryListTableViewController.swift
//  Grocery List
//
//  Created by Deborah Newberry on 6/5/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit
import CoreData
class GroceryListTableViewController: UITableViewController {
    var groceries = [Grocery]()
    var managedObjectContext: NSManagedObjectContext?
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add to List", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in }
        
        let add = UIAlertAction(title: "Add", style: .default) { [weak self] (addAction) in
            if let text = alertController.textFields?.first?.text {
                guard text != "" else {
                    return
                }
                let grocery = Grocery(context: (self?.managedObjectContext)!)
                grocery.item = text
                do {
                    try self?.managedObjectContext?.save()
                } catch {
                    fatalError("Failed to save")
                }
                self?.loadData()
            }
        }
        
        alertController.addAction(add)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
    }
    
    func loadData() {
        do {
            if let groceryItems = try managedObjectContext?.fetch(Grocery.fetchRequest()) as? [Grocery] {
                self.groceries = groceryItems
            }
            tableView.reloadData()
        } catch {
            fatalError("Error loading data")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        cell.textLabel?.text = groceries[indexPath.row].item
        return cell
    }
 
}
