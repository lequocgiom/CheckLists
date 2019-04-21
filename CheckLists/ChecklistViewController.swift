//
//  ViewController.swift
//  CheckLists
//
//  Created by Le Trung on 4/20/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
        
    }
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem) {
        
        items.append(item)
        tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)

    }
    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        let item1 = ChecklistItem()
        item1.text = "hello"
        item1.checked = false
        items.append(item1)
        super.init(coder: aDecoder)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.checked = !item.checked
            configureCheckmark(for: cell, with: item)
            tableView.reloadData()
        }
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    @IBAction func addItem(_ sender: Any) {
        let item = ChecklistItem()
        item.text = "I am a new row"
        item.checked = false
        items.append(item)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        }
        
        if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        
        label.text = item.checked ? "√" : ""
        
    }
    
    func configureText(for cell:UITableViewCell, with item: ChecklistItem)
    {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
}

