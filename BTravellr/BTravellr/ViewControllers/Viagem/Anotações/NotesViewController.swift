//
//  NotesViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

class NotesViewController: UIViewController{
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Anotações"
        view.addSubview(textView)
        
        setConstraints()
    }
    
    func setConstraints(){
        textView.frame = CGRect(x: 0, y: 0, width: Int(view.bounds.width), height: Int(view.bounds.height))
        textView.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
