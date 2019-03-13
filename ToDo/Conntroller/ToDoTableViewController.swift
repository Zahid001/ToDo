//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Md Zahidul Islam Mazumder on 10/3/19.
//  Copyright © 2019 Md Zahidul islam. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {

    var list = [Item]()
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemValues.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()


        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = list[indexPath.row].title

        cell.accessoryType = list[indexPath.row].check ? .checkmark : .none
        saveItem()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        list[indexPath.row].check = !list[indexPath.row].check

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        print(list[indexPath.row])
    }
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            let itm = Item(context: self.context)
            itm.title = textField.text!
            itm.check = false
            self.list.append(itm)
            
            self.saveItem()
            
            
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Create your own item"
            textField = UITextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem(){
        
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        do{
            //let request:NSFetchRequest<Item> =
            list = try context.fetch(request)
        }catch{
            print(error)
        }

        tableView.reloadData()
    }
    
    

}

extension ToDoTableViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty)! {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            loadData(with: request)
        }
        else{
            loadData()
        }
        
    }
}
