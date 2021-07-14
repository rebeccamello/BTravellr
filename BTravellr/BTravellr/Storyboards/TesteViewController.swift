//
//  ViewController.swift
//  SwipeAction
//
//  Created by Eugene Berezin on 5/16/20.
//  Copyright © 2020 Eugene Berezin. All rights reserved.
//

import UIKit

class TesteViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "text")
        tableView.backgroundColor = .systemGray5
        tableView.tableFooterView = UIView()
    }
    
//    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
//            guard let self = self else {return}
//
//            self.numberOfRows -= 1
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.tableView.reloadData()
//        }
        
       
        
//        return action
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath) as! TextFieldTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


}




