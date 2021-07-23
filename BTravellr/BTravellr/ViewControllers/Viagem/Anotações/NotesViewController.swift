//
//  NotesViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

class NotesViewController: UIViewController{
    let textView = UITextView()
    var trip: Trip?
    var note: Notes?
    var saveBut: UIBarButtonItem?

    init(trip: Trip) {
        self.trip = trip
        self.note = trip.tripNotes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Anotações"
        view.addSubview(textView)
        if let note = note{
            textView.text = note.text
        }
        saveBut = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveNote))
        
        navigationItem.rightBarButtonItem = saveBut
        
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
    
    @objc func saveNote(){
//        if textView.text != ""{
//            note.text = textView.text
//        }
        if note == nil{
            try? CoreDataStack.shared.createNote(textInput: textView.text!, trip: trip!)
        }
        else{
            try? CoreDataStack.shared.editNote(note: note!, text: textView.text!)
        }
    }
}
