//
//  TestePickerController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 13/08/21.
//

import Foundation
import UIKit

class TestePickerController: UIViewController, UITableViewDataSource{
    var texto = ["Ida", "Volta"]
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.identifier, for: indexPath) as? DatePickerCell
        cell?.textLabel?.text = texto[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "DatePickerCell")
        
        // #3
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.bounds.height*0.1),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -35)
        ])
    }
}
