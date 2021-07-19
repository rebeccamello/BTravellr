//
//  MyBagViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 16/07/21.
//

import UIKit

class MyBagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    struct listItem{
        var title: String
        var isChecked: Bool = false
    }
    
    var items = [listItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actItem))
        
        title = "Minha Mala"
        
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setConstraints()
    }
    
    @objc func actItem(_ sender: AnyObject){
        self.tableView.reloadData()
        self.items.append(listItem(title: "Mercury"))
        self.tableView.performBatchUpdates({
            self.tableView.insertRows(at: [IndexPath(row: self.items.count - 1,
                                                     section: 0)],
                                      with: .automatic)
        }, completion: nil)
    }
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            return table
        }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var item = items[indexPath.row]
        item.isChecked = !item.isChecked
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func setConstraints(){
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.bounds.height*0.1).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
}
