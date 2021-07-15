//
//  NotesViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

class NotesViewController: UIViewController{
    let textView = UITextView()
    let navBar = UINavigationBar()
    let navItem = UINavigationItem(title: "Anotações")
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        view.addSubview(textView)
        view.addSubview(navBar)
        view.addSubview(titleLabel)
        navBar.setItems([navItem], animated: false)
        setConstraints()
    }
    
    func setConstraints(){
        navBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        
        titleLabel.text = "Anotações"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textView.frame = CGRect(x: 10, y: 100, width: view.bounds.width, height: view.bounds.height*0.8)
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -30).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
}
