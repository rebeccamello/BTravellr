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
    var newItem = listItem(title: "", isChecked: false)
    var numberOfRows = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actItem))
        
        title = "Minha Mala"
        
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setConstraints()
        numberOfRows = items.count
    }
    
    @objc func actItem() -> Void{
        let root = NewItemViewController()
        root.delegate = self
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
        numberOfRows += 1
    }
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        //        print("aqui:", item.isChecked)
        if item.isChecked{
            //            print("checou")
            cell.accessoryType = .checkmark
        }
        else{
            //            print("deschecou")
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var item = items[indexPath.row]
        //        print(item.isChecked)
        item.isChecked = !item.isChecked
        //        print(item.isChecked)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (_, _, _) in
            guard let self = self else {return}
            self.numberOfRows -= 1
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        return action
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    func setConstraints(){
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.bounds.height*0.1).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
}

extension MyBagViewController: NewItemViewControllerDelegate{
    func updateItem(title: String) {
        items.append(listItem(title: title))
        tableView.reloadData()
    }
}
