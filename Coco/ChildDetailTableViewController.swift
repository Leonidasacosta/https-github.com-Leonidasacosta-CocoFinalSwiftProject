//
//  ChildDetailTableViewController.swift
//  Coco
//
//  Created by Leonidas Acosta on 11/30/21.
//

import UIKit
import Firebase

class ChildDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var childNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var childrens: Children!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        if childrens == nil {
            childrens = Children(name: "", age: "0")
            saveButton.isEnabled = false
        } else {
            disableTextEditing()
            saveButton.isEnabled = true
            navigationController?.setToolbarHidden(true, animated: true)
        }
        updateUserInterface()
        
    }
    
    func updateUserInterface() {
        childNameTextField.text = childrens.name
        ageTextField.text = "\(childrens.age)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        childrens = Children(name: childNameTextField.text!, age: ageTextField.text!)
    }
    func enableDisableSaveButton(text: String) {
        if text.count > 0 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        let noSpaces = childNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if noSpaces != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }

    func disableTextEditing() {
        childNameTextField.isEnabled = true
        ageTextField.isEnabled = true
    }
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
}
