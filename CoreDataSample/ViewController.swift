//
//  ViewController.swift
//  CoreDataSample
//
//  Created by MS1 on 9/12/17.
//  Copyright © 2017 gideon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let cellId = "cellId"
    
    var people: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        guard let app = UIApplication.shared.delegate as? AppDelegate else {return}
        let moc = app.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            
            people = try moc.fetch(fetchRequest)
            
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addName(_ sender: Any) {
       
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)

        
       let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] (action) in
        guard let textField = alert.textFields?.first, let nameToSave = textField.text else {return}
        self.save(name : nameToSave)
        self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    fileprivate func save(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let moc = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: moc)!
        
        let person = NSManagedObject(entity: entity, insertInto: moc)
        
        person.setValue(name, forKey: "name")
       
        do {
            try moc.save()
            people.append(person)
            
        } catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell =
                tableView.dequeueReusableCell(withIdentifier: cellId,
                                              for: indexPath)
            let person = people[indexPath.row]
            cell.textLabel?.text = person.value(forKeyPath: "name") as? String
            return cell }
}
