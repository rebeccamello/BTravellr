//
//  NewItemViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 19/07/21.
//

import UIKit

struct ItemStruct{
    var itemName: String
}

class NewItemViewController: UIViewController {
    let textField: UITextField = UITextField (frame:CGRect(x: 10, y: 10, width: 50, height: 10))
    var name: String = ""
    weak var delegate: NewItemViewControllerDelegate?
    let item = ItemStruct(itemName: "")
    var trip: Trip
    
    init(tripInfos: Trip) {
        self.trip = tripInfos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Feito", style: .plain, target: self, action: #selector(done))
        title = "Adicionar item"
        
        view.addSubview(textField)
        textField.placeholder = "    Nome do item"
        textField.backgroundColor = #colorLiteral(red: 0.9058129191, green: 0.905921638, blue: 0.9057757854, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        setConstraints()
    }
    
    @IBAction func cancel() -> Void{
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() -> Void{
        name = textField.text!
        self.dismiss(animated: true, completion: nil)
        guard let bag = try? CoreDataStack.shared.createBagItem(itemName: name, trip: trip) else{ return}
        delegate?.updateItem(bag: bag)
    }
    
    func setConstraints(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }
}

