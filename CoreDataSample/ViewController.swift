//
//  ViewController.swift
//  CoreDataSample
//
//  Created by MS1 on 9/12/17.
//  Copyright © 2017 gideon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let cellId = "cellId"
    
    var names: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        self.names.append(nameToSave)
        self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell =
                tableView.dequeueReusableCell(withIdentifier: cellId,
                                              for: indexPath)
            cell.textLabel?.text = names[indexPath.row]
            return cell }
}
