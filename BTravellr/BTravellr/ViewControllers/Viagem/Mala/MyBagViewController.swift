//
//  MyBagViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 16/07/21.
//

import UIKit
import CoreData

class MyBagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    struct listItem {
        var title: String
        var isChecked: Bool = false
    }
    
    var items = [listItem]()
    var newItem = listItem(title: "", isChecked: false)
    var numberOfRows = Int()
    var trip: Trip
    
    init(tripInfos: Trip) {
        self.trip = tripInfos
        super.init(nibName: nil, bundle: nil)
        let bags = (trip.tripBagItems?.allObjects as? [Bag])
        items = bags?.map{
            bag -> listItem in
            listItem(title: bag.itemName ?? "")
        } ?? []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    func setConstraints(){
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.bounds.height*0.1).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.2).isActive = true
    }
    
    @objc func actItem() -> Void{
        let root = NewItemViewController(tripInfos: trip)
        root.delegate = self
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
        numberOfRows += 1
    }
    
    //MARK: TableView
    
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
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
//    private func delete(item: Bag) -> UIContextualAction{
//        let action = UIContextualAction(style: .destructive, title: "Deletar") {_,_,_ in
//            do{
//                try CoreDataStack.shared.deleteBagItem(item: item)
//            } catch{
//                print("Falhou")
//            }
//        }
//        return action
//    }

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        items.remove(at: indexPath.row)
//        let item = items[indexPath.row]
////        let swipe = UISwipeActionsConfiguration(actions: delete(item: item))
////        return swipe
//        return
//    }
}

extension MyBagViewController: NewItemViewControllerDelegate{
    func updateItem(title: String) {
        items.append(listItem(title: title))
        tableView.reloadData()
    }
}
