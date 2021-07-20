//
//  NewItemViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 19/07/21.
//

import UIKit

class NewItemViewController: UIViewController {
    let textField: UITextField = UITextField (frame:CGRect(x: 10, y: 10, width: 50, height: 10))
    var name: String = ""
    
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
        setConstraints()
    }
    
    @IBAction func cancel() -> Void{
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() -> Void{
        name = textField.text!
    }
    
    func setConstraints(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        
    }
}

