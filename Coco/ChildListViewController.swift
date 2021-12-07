//
//  ChildListViewController.swift
//  Coco
//
//  Created by Leonidas Acosta on 11/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class ChildListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!

    var childrens = Childs()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureSegmentedControl()
        childrens.loadData {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    func configureSegmentedControl() {
        // set font colors for segmented control
        let pinkFontColor = [NSAttributedString.Key.foregroundColor : UIColor.systemPink]
        let whiteFontColor = [NSAttributedString.Key.foregroundColor : UIColor.white]
        sortSegmentedControl.setTitleTextAttributes(pinkFontColor, for: .selected)
        sortSegmentedControl.setTitleTextAttributes(whiteFontColor, for: .normal)
        // add white border to segmented control
        sortSegmentedControl.layer.borderColor = UIColor.white.cgColor
        sortSegmentedControl.layer.borderWidth = 1.0
    }
    func sortBasedOnSegmentPressed() {
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0: //A-Z
            childrens.childArray.sort(by: {$0.name < $1.name})
        case 1: //child age
            childrens.childArray.sort(by: { $0.age > $1.age})
        default:
            print("HEY! You shouldn't have gotten here. Check out the segmented control for an error!")
        }
        tableView.reloadData()
    }
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    
    func saveData() {
        childrens.saveData()
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! ChildDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            childrens.childArray[selectedIndexPath.row] = source.childrens
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: childrens.childArray.count, section: 0)
            childrens.childArray.append(source.childrens)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChild" {
            let destination = segue.destination as! ChildDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.childrens = childrens.childArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing { // If button clicked while editing, I'm done.
            tableView.setEditing(false, animated: true) // turn off tableView editing
            editBarButton.title = "Edit" //Set button label so it can re-start edit
            addBarButton.isEnabled = true // enable the "+" button
        } else { // I wasn't editing, so start editing
            tableView.setEditing(true, animated: true) // turn on tableView editing
            editBarButton.title = "Done" // set button label so it can stop edit
            addBarButton.isEnabled = false // disable the "+" button, don't add if editing
        }
    }
}
extension ChildListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrens.childArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChildTableViewCell
        cell.child = childrens.childArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            childrens.childArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let childToMove = childrens.childArray[sourceIndexPath.row]
        childrens.childArray.remove(at: sourceIndexPath.row)
        childrens.childArray.insert(childToMove, at: destinationIndexPath.row)
        saveData()
    }
    
}


