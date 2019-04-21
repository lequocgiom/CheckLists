//
//  itemDetailViewController.swift
//  CheckLists
//
//  Created by Le Trung on 4/20/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV)
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem)
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: ChecklistItem)
}
class ItemDetailV: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField : UITextField!
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    var itemToEdit: ChecklistItem?
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    @IBAction func cancle() {
        navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        }
        else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        }
        
        else {
            doneBarButton.isEnabled = true
        }
        
        return true
    }
}
