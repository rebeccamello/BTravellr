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
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Anotações"
        view.addSubview(textView)

        setConstraints()
    }
    
    func setConstraints(){
        
        textView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height*0.9)
//        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        textView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
//        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
}
