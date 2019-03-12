//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Md Zahidul Islam Mazumder on 10/3/19.
//  Copyright © 2019 Md Zahidul islam. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var list = [Item]()
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemValues.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let items = defaults.value(forKey: "listValue") as? [Item]{
//            list = items
//        }
        
        loadData()
        //print(dataFilePath!)
     
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.textLabel?.text = list[indexPath.row].name

        cell.accessoryType = list[indexPath.row].check ? .checkmark : .none
        saveItem()
//        if list[indexPath.row].check  {
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        //print(list[indexPath.row].check)
        //tableView.reloadData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        list[indexPath.row].check = !list[indexPath.row].check
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        print(list[indexPath.row])
    }
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            let itm = Item()
            itm.name = textField.text!
            self.list.append(itm)
            
            self.saveItem()
            
            
            //self.defaults.setValue(self.list, forKey: "listValues")
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
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(list)
            try data.write(to: dataFilePath!)
        }catch{
            print(error)
        }
    }
    func loadData(){
        do{
            let data = try Data(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            
            list = try decoder.decode([Item].self, from: data)
        }catch{
            print(error)
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
